Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRKNRZg>; Wed, 14 Nov 2001 12:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277228AbRKNRZ0>; Wed, 14 Nov 2001 12:25:26 -0500
Received: from [64.92.133.94] ([64.92.133.94]:32006 "HELO boxxtech.com")
	by vger.kernel.org with SMTP id <S274862AbRKNRZK>;
	Wed, 14 Nov 2001 12:25:10 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Marvin Justice <mjustice@boxxtech.com>
Reply-To: mjustice@boxxtech.com
Organization: BOXX Technologies, Inc.
To: "Ion Badulescu" <ionut@cs.columbia.edu>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: What Athlon chipset is most stable in Linux?
Date: Wed, 14 Nov 2001 11:24:56 -0600
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3B6867E6CB09B24385A73719A50C7C9A797750@athena.boxxtech.com>
In-Reply-To: <3B6867E6CB09B24385A73719A50C7C9A797750@athena.boxxtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200111141119328.SM01008@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 762 North Bridge definitely has AGP issues and will lock up with GeForce 
3 and nVidia's latest official drivers. I just got my hands on beta drivers  
and the lockups appear to have gone away --- so far ;-) Their binary only 
kernel module has functions with names ike "AMD_FixupGART", 
"AMD_ApplyChipsetUpdates" etc.

-Marvin


On Wednesday 14 November 2001 10:54 am, Ion Badulescu wrote:
> On Tue, 13 Nov 2001 19:16:07 -0800 (PST), David S. Miller 
<davem@redhat.com> wrote:
>  >   From: Dan Hollis <goemon@anime.net>
>  >   Date: Tue, 13 Nov 2001 19:11:56 -0800 (PST)
>  >
>  >   BTW this bug apparently doesnt affect AMD760MP as I am able to use
>  >   geforce2 with quake and unreal tournament for hours straight without
>  > any problems.
>  >
>  > I'm rather sure the AMD761 problems are motherboard vendor
>  > independant, because I have 2 systems so far, using totally different
>  > AMD761 based motherboards, which both hang pretty reliably with AGP.
>
> As far as I know, the 760MP chipset uses a 762 North Bridge, not a 761.
>  That might explain why the 760MP is stable and the 760 is not.
>
> Ion
