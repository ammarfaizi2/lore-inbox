Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTFCVPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 17:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTFCVPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 17:15:31 -0400
Received: from palrel11.hp.com ([156.153.255.246]:43667 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261241AbTFCVPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 17:15:31 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16093.4884.519056.689668@napali.hpl.hp.com>
Date: Tue, 3 Jun 2003 14:28:52 -0700
To: Russell King <rmk@arm.linux.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>, davidm@hpl.hp.com
Subject: Re: no-omit-frame-pointer for sched.c in 2.4-i386
In-Reply-To: <20030603222152.A18010@flint.arm.linux.org.uk>
References: <20030603210617.GE3661@werewolf.able.es>
	<20030603222152.A18010@flint.arm.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 3 Jun 2003 22:21:52 +0100, Russell King <rmk@arm.linux.org.uk> said:

  Russell> Maybe the right solution would be to do something like:

  Russell> CFLAGS_sched.o	:= $(EXTRA_CALLTRACE_FLAGS)

  Russell> and architectures can define EXTRA_CALLTRACE_FLAGS appropriately.

That would work for me.

	--david
