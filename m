Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132818AbRA0LBK>; Sat, 27 Jan 2001 06:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132890AbRA0LBB>; Sat, 27 Jan 2001 06:01:01 -0500
Received: from [194.213.32.137] ([194.213.32.137]:38916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132818AbRA0LA1>;
	Sat, 27 Jan 2001 06:00:27 -0500
Message-ID: <20010126184137.C260@bug.ucw.cz>
Date: Fri, 26 Jan 2001 18:41:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: vfat <-> vfat copying of ~700MB file, so slow!
In-Reply-To: <20010124131431.A19957@ikar.t17.ds.pwr.wroc.pl> <200101242053.f0OKrps154856@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200101242053.f0OKrps154856@saturn.cs.uml.edu>; from Albert D. Cahalan on Wed, Jan 24, 2001 at 03:53:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Copying between vfat <-> vfat partitions is so slow. It seems
> > that it's vfat/msdos kernel driver problem because I tried to copy
> 
> I reported this years ago, with a 700 kB file on a floppy and
> a 4 MB file on a Zip disk. In both cases mcopy was several times
> faster than the kernel code.

Perhaps linear scan of FAT?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
