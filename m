Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWBMQio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWBMQio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWBMQio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:38:44 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:7167 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750819AbWBMQim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:38:42 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 17:37:18 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jerome.lacoste@gmail.com, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0B5BE.nailMBX2SZNBE@burner>
References: <20060208162828.GA17534@voodoo>
 <43EC887B.nailISDGC9CP5@burner>
 <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner>
 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
 <43F06220.nailKUS5D8SL2@burner>
 <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
 <43F0A010.nailKUSR1CGG5@burner>
 <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com>
 <43F0AA83.nailKUS171HI4B@burner>
 <5a2cf1f60602130805u537de206k22fa418ee214cf02@mail.gmail.com>
 <43F0B2BA.nailKUS1DNTEHA@burner>
 <Pine.LNX.4.61.0602131732190.24297@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602131732190.24297@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >> The information printed will be printed in a format such as:
> >>
> >> b,t,l <= os_specific_name
> >
> >Why do you believe that this kind of mapping is needed?
> >
>
> Assume the user has a /dev/white_dvd and a /dev/black_dvd, both of being 
> the same brand. `cdrecord -scanbus` would return sth like
>
> scsibus0:
>         0,0,0     0) *
>         0,1,0     1) 'HL-DT-ST' 'DVDRAM GSA-4160B' 'A301' Removable CD-ROM
>         0,2,0     2) *
>         0,3,0     3) *
>         0,4,0     4) *
>         0,5,0     5) *
>         0,6,0     6) *
>         0,7,0     7) *
> scsibus1:
>         1,0,0     0) *
>         1,1,0     1) 'HL-DT-ST' 'DVDRAM GSA-4160B' 'A301' Removable CD-ROM
>         1,2,0     2) *
>         1,3,0     3) *
>         1,4,0     4) *
>         1,5,0     5) *
>         1,6,0     6) *
>         1,7,0     7) *
>
> probably. But how to find out from the btl which one is the black and which 
> one is the white one?

A user has a bigger chance to do that from b,t,l than a program has when
trying possible aliases....

And if you have a working vold on Solaris, libscg accepts the vold aliases.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
