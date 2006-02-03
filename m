Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWBCKH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWBCKH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWBCKH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:07:29 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:63987 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751157AbWBCKH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:07:28 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 11:06:09 +0100
To: schilling@fokus.fraunhofer.de, grundig@teleline.es
Cc: xavier.bestel@free.fr, schilling@fokus.fraunhofer.de, oliver@neukum.org,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E32B11.nail5CA21ENV6@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43DF3C3A.nail2RF112LAB@burner>
 <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
 <200601311333.36000.oliver@neukum.org>
 <1138867142.31458.3.camel@capoeira> <43E1EAD5.nail4R031RZ5A@burner>
 <1138880048.31458.31.camel@capoeira> <43E20047.nail4TP1PULVQ@burner>
 <20060202143202.3c2bd4a3.grundig@teleline.es>
In-Reply-To: <20060202143202.3c2bd4a3.grundig@teleline.es>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<grundig@teleline.es> wrote:

> El Thu, 02 Feb 2006 13:51:19 +0100,
> Joerg Schilling <schilling@fokus.fraunhofer.de> escribió:
>
> > Libscg is _the_ HAL for cdrecord. It is availaible the same way as today since
> > 10 years.
>
>
> libscg being there for 10 years doesn't means that it's the right or the
> better way of doing things.

Any new implementation first needs to prove that it is durable and (more 
important) that it is actively maintained. I am sure that this kind of software 
will never handle all oddities in drive firmware we know from CD/DVD-writers.


> Hal is _the_ HAL for linux, in fact HAL is targetted to become _the_
> "standard" (freedesktop standard) HAL for open operative systems. HAL
> should be already available on solaris, at least there's a @sun.com guy
> who created a hald/solaris/ directory (gnome is already using HAL and
> sun is interested in gnome). It doesn't seem to do nothing today but I

I know this person, but Sun is creating reliable software for customers and for 
this reason, it is most unlikely that an incompatible change like this will 
be intregrated before Solaris 11 GA is available to the end of 2007.
It may appear earlier in Solaris 11 beta's, but this is a different thing.

> bet that sun is interested in getting HAL working in solaris (there're
> at least people in the opensolaris mailing lists interested). I guess
> the BSD guys will end up implementing BSD support some day aswell - desktop
> is not as important for them as it is for linux.
>
> So the fact is that HAL is quickly becoming _the_ HAL for unix systems.

I hope that Sun will not base Sun's implementations on ideas on the Linux 
implementaion which is known to be an "unfriendly" program as it causes 
problems with CD/DVD-writing.

Since 1992, Sun has vold and vold is rock solid. Vold nicely coexists with 
cdrecord in the right way: It does not send inapropriate SCSI commnds to the 
drives and it does not send too many of them in a certain period of time.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
