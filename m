Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbUDFXPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbUDFXPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:15:50 -0400
Received: from palrel13.hp.com ([156.153.255.238]:61068 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263926AbUDFXPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:15:48 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16499.14880.938413.166692@napali.hpl.hp.com>
Date: Tue, 6 Apr 2004 16:15:44 -0700
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       p_gortmaker@yahoo.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] don't offer GEN_RTC on ia64
In-Reply-To: <200404061637.48475.bjorn.helgaas@hp.com>
References: <200404061622.49260.bjorn.helgaas@hp.com>
	<20040406223416.GH31152@smtp.west.cox.net>
	<200404061637.48475.bjorn.helgaas@hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 6 Apr 2004 16:37:48 -0600, Bjorn Helgaas <bjorn.helgaas@hp.com> said:

  Bjorn> I'd actually like to do that, but that's a longer-term
  Bjorn> project.  And I don't know the history behind efi_rtc, so
  Bjorn> maybe there's a good reason for it being separate.

AFAIR, when efirtc was being written, the normal RTC driver was
specific to the PC clock chips (mc14whatever) and it wasn't clear
whether it should even try to be generic.  I don't think anybody is
particularly attached to the bits.

	--david
