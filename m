Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbTDRS5J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTDRS5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:57:09 -0400
Received: from palrel13.hp.com ([156.153.255.238]:51890 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263194AbTDRS5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:57:09 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16032.19793.17108.442072@napali.hpl.hp.com>
Date: Fri, 18 Apr 2003 12:09:05 -0700
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] archs: vmlinux.lds.S unification
In-Reply-To: <Pine.LNX.4.44.0304180925320.9070-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0304180925320.9070-100000@chaos.physics.uiowa.edu>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Kai> Does IA-64 still need to discard .comment, .note? (is SoftDSV
  Kai> still buggy and in use?)

I haven't heard of anyone using SoftSDV in 2+ years or so.  Of course,
that doesn't mean there aren't any users there...

Perhaps a better question to ask: is there any reason to _ever_
include those sections in the kernel?

	--david
