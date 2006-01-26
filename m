Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWAZMjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWAZMjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 07:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWAZMjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 07:39:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50849 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751339AbWAZMjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 07:39:15 -0500
Date: Thu, 26 Jan 2006 13:39:14 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jerome.lacoste@gmail.com, axboe@suse.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060126.122723.14374.atrey@ucw.cz>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <5a2cf1f60601251401h2cced00ele307636e748b9a7b@mail.gmail.com> <43D8BCFE.nailE1C116RR9@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D8BCFE.nailE1C116RR9@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Linux developers seem to see the world in a different way. Their main
> > requirements:
> > - compliance with the linux way of doing things
> 
> Which is unfortunately (in contrary to what cdrecord does) a moving target.

Which is *fortunately* a moving target, because what served well 20 years
ago is unlikely to serve equally well *now*.

Having a stable naming of devices is a good goal, but in no way restricted
to SCSI-like devices. What you suggest works only there, what Linux currently
uses (udev etc.) works for all devices. Guess which is better for most users.

> BTW: There are still many people who run Linux-2.2 and many people told me that
> they will probably never upgrade from 2.4 to 2.6.

Fine, so feel free consider Linux <2.6 and Linux 2.6 two completely
separate operating systems. I did the same with the IP stack interface
in the BIRD project and I consider it a very good step -- the old
interface provided by Linux 2.0 and cluttered with BSD compatibility is
almost unusable when compared to Netlink, but for sake of users who
don't want to upgrade their kernel, BIRD is able to use the old one,
though with limited functionality.

> On Linux-2.4, cdrecord's abstraction is the only way to hide the security 
> relevent non-stable /dev/sg* <-> device relation.

OK. So welcome to year 2006. And to Linux 2.6.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
How do I type 'for i in *.dvi ; do xdvi $i ; done' in a GUI?
