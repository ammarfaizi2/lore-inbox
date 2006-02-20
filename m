Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWBTQG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWBTQG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWBTQG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:06:59 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:59540 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030298AbWBTQG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:06:58 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 20 Feb 2006 17:05:22 +0100
To: schilling@fokus.fraunhofer.de, davidsen@tmr.com
Cc: nix@esperi.org.uk, mj@ucw.cz, linux-kernel@vger.kernel.org,
       chris@gnome-de.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F9E8C2.nail4ALB11DH3@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43ED005F.5060804@tmr.com>
 <1139615496.10395.36.camel@localhost.localdomain>
 <43F088AB.nailKUSB18RM0@burner>
 <mj+md-20060213.135336.28566.atrey@ucw.cz>
 <43F0A319.nailKUSXT33MZ@burner> <43F7257D.80400@tmr.com>
In-Reply-To: <43F7257D.80400@tmr.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:

> >If you did ever try to write reliable code that has to deal with this kind of
> >oddities, you would understand that it is sometimes better to wait and to inform
> >related people about the problems they caused.
> >  
> >
> This ground has been covered. And at least in the case of filtering 
> commands, that had to be done quickly and you know it.

We all know that filtering is not needeed to fix a bug. It could have been
implemented completely relaxed and without any time pressure as the bug
that needed fixing could have been fixed by just requiring a R/W FD to allow
SG_IO. 

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
