Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUD1A4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUD1A4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUD1A4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:56:45 -0400
Received: from gprs214-84.eurotel.cz ([160.218.214.84]:26755 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264540AbUD1A4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:56:43 -0400
Date: Wed, 28 Apr 2004 02:56:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: 234976@bugs.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040428005627.GA20405@elf.ucw.cz>
References: <1Pc0Y-BC-45@gated-at.bofh.it> <1PcWn-1tE-11@gated-at.bofh.it> <1Pf8I-3qP-31@gated-at.bofh.it> <1PuTf-7ZO-7@gated-at.bofh.it> <1Py1q-1ZH-23@gated-at.bofh.it> <1Py1y-1ZH-43@gated-at.bofh.it> <1PAlX-3Vx-1@gated-at.bofh.it> <20040427233009.GA24051@hell.org.pl> <20040427233341.GA6592@elf.ucw.cz> <20040427234653.GA23804@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427234653.GA23804@hell.org.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Thus wrote Pavel Machek:
> > > > This should be better solution, could anyone test it? [It compiles,
> > > > and I'm out of time now].
> > > It reboots my system while reading pageset.
> > And it worked before?
> 
> Right, you didn't receive that. Yes, plain swsusp1 passes that stage but
> hangs or reboots during copying (or a little bit after) and with Herbert 
> Xu's patch I can suspend and resume with glxgears running.
> Best regards,

Ouch, you are using old version of patch, that puts swsusp_pg_dir at
non-page-aligned address => crash. Can you try newer one? [I'm fwd-ing
it to you in private mail].
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
