Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUJLTFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUJLTFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUJLTFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:05:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:744 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267518AbUJLTFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:05:18 -0400
Subject: Re: 2.6.9-rc4-mm1 Oops [2]
From: Lee Revell <rlrevell@joe-job.com>
To: Valdis.Kletnieks@vt.edu
Cc: Mathieu Segaud <matt@minas-morgul.org>, sboyce@blueyonder.co.uk,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200410121607.i9CG7PsQ001076@turing-police.cc.vt.edu>
References: <416B9517.7010708@blueyonder.co.uk>
	 <877jpwi8cg.fsf@barad-dur.crans.org>
	 <200410121607.i9CG7PsQ001076@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1097607706.1553.79.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 15:01:46 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 12:07, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 12 Oct 2004 11:39:11 +0200, Mathieu Segaud said:
> > Sid Boyce <sboyce@blueyonder.co.uk> disait dernièrement que :
> > 
> > > This one on attempting to start firefox.
> > > Regards
> > > Sid.
> > 
> > about the 2 reports you made about oopses, try this
> > cd /path/to/your/kernel/source
> > wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/
> 2.6.9-rc4-mm1/nroken-out/optimize-profile-path-slightly.patch
> > patch -R -p1 -i optimize-profile-path-slightly.patch
> 
> I started seeing the same problem on -rc4-mm1, and couldn't figure out why
> I didn't see it on -rc3-mm3.  Finally figured out that it was because the
> -rc3-mm3 had a -VP patch on it, and the -rc4-mm1 didn't (because of the
> UP build problems in -T5).  Ingo's patch also reverts that patch, so I got
> the fix 'free of charge'....

I assumed that Ingo added this to the VP patch intentionally so he
didn't get a zillion bug reports.

Lee

