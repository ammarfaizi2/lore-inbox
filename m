Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285016AbRLZWtz>; Wed, 26 Dec 2001 17:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285013AbRLZWtp>; Wed, 26 Dec 2001 17:49:45 -0500
Received: from ns1.system-techniques.com ([199.33.245.254]:22682 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S285016AbRLZWtn>; Wed, 26 Dec 2001 17:49:43 -0500
Date: Wed, 26 Dec 2001 17:49:37 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Arturas V <arturasv@hotmail.com>
cc: linux-kernel@vger.kernel.org, <avaitaitis@bloomberg.net>
Subject: Re: Proliant hangs with 2.4 but works with 2.2. 
In-Reply-To: <F105uevz176RbFGIUUJ0000fff8@hotmail.com>
Message-ID: <Pine.LNX.4.43.0112261747460.18080-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Arturus ,  Fyi ,  The SYM2 version of the 53c8xx driver
	(imo) has better support for both the older & newer chips .
	The first 2.4 kernel with the SYM2 included is 2.4.16 (iirc) .
		Hth ,  JimL

On Wed, 26 Dec 2001, Arturas V wrote:
> lafanga lafanga wrote:
> >I have a Compaq Proliant 1600 server which can be hung on demand with >all
> >the 2.4 series kernels I have tried (2.4, 2.4.1 & 2.4.2-pre3). >Kernel
> >2.2.16 runs perfectly (from a default RH7.0).
>
> >I have ensured that the server meets the necessary requirements for >the
> >2.4 kernels (modutils etc) and I have tried kgcc and various gcc versions.
> > >When compiling I have tried default configs and also minimalist configs
> >(with only cpqarray and tlan). I have also ensured that I have the latest
> > >current SmartStart CD (4.9) and have setup the firmware for installing
> >Linux.
>
> I had similar problem with 2.4.5 Kernel. I managed to solve the problem by
> configuring a working verion of kernel with
> NCR53C8XX SCSI support as well as SYM53C8XX. As far as I understood
> SYM53C8xx support covers 53C8xx chips better than NCR53C8xx and that makes
> all the difference. Anyone understands why?
> ---
> Arturas Vaitaitis.
> ---
> Please CC to arturv@acedsl.com
> P.S. Intelligence has yet to prove its survival value
>
> _________________________________________________________________
> Send and receive Hotmail on your mobile device: http://mobile.msn.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

