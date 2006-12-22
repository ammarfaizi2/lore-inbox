Return-Path: <linux-kernel-owner+w=401wt.eu-S1753051AbWLWJhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbWLWJhT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 04:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbWLWJhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 04:37:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1158 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752957AbWLWJhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 04:37:15 -0500
Date: Fri, 22 Dec 2006 20:34:17 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Olivier Galibert <galibert@pobox.com>,
       Andrew Robinson <andrew.rw.robinson@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: suspend to disk (was Re: ReiserFS corruption with 2.6.19 (Was 2.6.19 is not stable with SATA and should not be used by any meansis not stable with SATA and should not be used by any means))
Message-ID: <20061222203417.GA3960@ucw.cz>
References: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com> <20061212224527.GA4045@dspnet.fr.eu.org> <20061215161544.GC4551@ucw.cz> <4583B748.2080809@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4583B748.2080809@wolfmountaingroup.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Stop spreading fud. Take powersave + suspend from 
> >suse10.2, and see
> >if you can break it.
> >
> >sata_nv seems to have problem, that's it. and it 
> >triggered problem in
> >reiserfs. Use ext3 if you care about your data, and yes 
> >your drivers
> >need to support suspend/resume.

> >
> My Compaq laptop, a Presario 2200, has video lockups 
> using suspend to disk and a dead system everytime I use 
> it. I don't

Try with vga=1 (no framebuffer) and minimum number of modules.

> think its fud. I also conceed its not Linux's fault most 
> of the time. These vendors put Windows specific hardware 

suspend to ram is usually video bios problem; suspend to disk tends to
be linux problem.
							Pavel

-- 
Thanks for all the (sleeping) penguins.
