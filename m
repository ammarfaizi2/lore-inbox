Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUD1JFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUD1JFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 05:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264698AbUD1JFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 05:05:54 -0400
Received: from hell.org.pl ([212.244.218.42]:47630 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264703AbUD1JFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 05:05:35 -0400
Date: Wed, 28 Apr 2004 11:05:35 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Pavel Machek <pavel@ucw.cz>
Cc: 234976@bugs.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040428090535.GA20653@hell.org.pl>
References: <1PcWn-1tE-11@gated-at.bofh.it> <1Pf8I-3qP-31@gated-at.bofh.it> <1PuTf-7ZO-7@gated-at.bofh.it> <1Py1q-1ZH-23@gated-at.bofh.it> <1Py1y-1ZH-43@gated-at.bofh.it> <1PAlX-3Vx-1@gated-at.bofh.it> <20040427233009.GA24051@hell.org.pl> <20040427233341.GA6592@elf.ucw.cz> <20040427234653.GA23804@hell.org.pl> <20040428005627.GA20405@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20040428005627.GA20405@elf.ucw.cz>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Pavel Machek:
> > Right, you didn't receive that. Yes, plain swsusp1 passes that stage but
> > hangs or reboots during copying (or a little bit after) and with Herbert 
> > Xu's patch I can suspend and resume with glxgears running.
> Ouch, you are using old version of patch, that puts swsusp_pg_dir at
> non-page-aligned address => crash. Can you try newer one? [I'm fwd-ing
> it to you in private mail].

Yes, the updated patch also fixes this bug.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
