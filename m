Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTBPDOj>; Sat, 15 Feb 2003 22:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTBPDOj>; Sat, 15 Feb 2003 22:14:39 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:19605
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S265725AbTBPDOi>; Sat, 15 Feb 2003 22:14:38 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: David Ford <david+cert@blue-labs.org>, paul@laufernet.com
Subject: Re: OSS Sound Blaster sb_card.c rewrite (PnP, module options, etc) - UPDATE
Date: Sat, 15 Feb 2003 22:26:14 -0500
User-Agent: KMail/1.6
References: <Pine.LNX.4.44.0302130004470.247-100000@coredump.sh0n.net> <3E4E7328.1090807@blue-labs.org>
In-Reply-To: <3E4E7328.1090807@blue-labs.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302152226.14112.spstarr@sh0n.net>
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.114.185.204] using ID <shawn.starr@rogers.com> at Sat, 15 Feb 2003 22:24:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, But you require Adam Belay's new PnP patches and an additional patch to 
fix an oops problem ;-) 

I think Adam will have those patches on lkml soon. If you can't find any of 
the patches, I can send them. I'm testing the PnP bug fixes as we speak so 
I'll do some sanity checking to see if they work right.

The sound blaster patches are from Paul and you can find them on lkml about 
1-2 weeks ago.

Shawn.

On Saturday 15 February 2003 12:04 pm, David Ford wrote:
> Are you using or in possession of a patch for sb16 and recent 2.5.xx
> such as 2.5.61?
>
> sound/isa/sb/sb16.c: In function `snd_sb16_isapnp':
> sound/isa/sb/sb16.c:279: warning: implicit declaration of function
> `isapnp_find_dev'
> sound/isa/sb/sb16.c:279: warning: assignment makes pointer from integer
> without a cast
> sound/isa/sb/sb16.c:280: structure has no member named `active'
> sound/isa/sb/sb16.c:293: structure has no member named `prepare'
> sound/isa/sb/sb16.c:296: warning: implicit declaration of function
> `isapnp_resource_change'
> sound/isa/sb/sb16.c:307: structure has no member named `activate'
> sound/isa/sb/sb16.c: In function `snd_sb16_deactivate':
> sound/isa/sb/sb16.c:347: structure has no member named `deactivate'
> sound/isa/sb/sb16.c: In function `alsa_card_sb16_init':
> sound/isa/sb/sb16.c:632: warning: implicit declaration of function
> `isapnp_probe_cards'
> make[3]: *** [sound/isa/sb/sb16.o] Error 1
>
> -d
>
> Shawn Starr wrote:
> >With Adam's new PnP changes, and the disabling of the OS PnP BIOS on the
> >IBM. I can say that your sb_card.c/h changes (with some small
> >modifications with the new PnP structure changes) works!
> >
> >I suppose, this weekend I could see if I can get the AWE itself detected
> >on 2.5.60 now :-)
> >
> >Shawn.

