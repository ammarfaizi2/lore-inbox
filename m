Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWBMSNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWBMSNX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWBMSNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:13:23 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:57040 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932251AbWBMSNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:13:22 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 19:12:00 +0100
To: schilling@fokus.fraunhofer.de, jerome.lacoste@gmail.com
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0CBF0.nailMFL11QJR1@burner>
References: <20060208162828.GA17534@voodoo>
 <43EC8F22.nailISDL17DJF@burner>
 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
 <43F06220.nailKUS5D8SL2@burner>
 <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
 <43F0A010.nailKUSR1CGG5@burner>
 <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com>
 <43F0AA83.nailKUS171HI4B@burner>
 <5a2cf1f60602130805u537de206k22fa418ee214cf02@mail.gmail.com>
 <43F0B2BA.nailKUS1DNTEHA@burner>
 <5a2cf1f60602130912u7e8d28c4w4ef1749ff6c73142@mail.gmail.com>
In-Reply-To: <5a2cf1f60602130912u7e8d28c4w4ef1749ff6c73142@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:

> To make it so that:
>
> - cdrecord keeps its dev=b,t,l command line interface
>
> - a cdrecord wrapper program lets a user specify the os specific name
> to access the drive. The wrapper program would identify the b,t,l name
> and feed it correctly to cdrecord. This can also be used to correctly
> identify 2 identical drives using their OS specific names.
>
> -scanbus displays:
> 1,0,0: DRIVE MODEL XYZ
> 2,0,0: DRIVE MODEL XYZ
>
> but thank to that proposal, one would also have:
>
> 1,0,0 <= /dev/hdc
> 2,0,0 <= /dev/hdd
>
> I think it's a good compromise between what the users want and what you want.
>
> So, WDYT?

If this would not be Linux only, go ahead.

Note that you would have to do real hard work as it is not trivial to prove your
patch on all supported OS....


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
