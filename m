Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbTALQI2>; Sun, 12 Jan 2003 11:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTALQI1>; Sun, 12 Jan 2003 11:08:27 -0500
Received: from dialin-145-254-067-169.arcor-ip.net ([145.254.67.169]:11392
	"EHLO portable.localnet") by vger.kernel.org with ESMTP
	id <S267236AbTALQI1>; Sun, 12 Jan 2003 11:08:27 -0500
Date: Sun, 12 Jan 2003 17:14:34 +0100 (CET)
Message-Id: <20030112.171434.640902628.rene.rebe@gmx.net>
To: babydr@baby-dragons.com
Cc: kernel@nn7.de, linux-kernel@vger.kernel.org
Subject: Re: choice of raid5 checksumming algorithm wrong ?
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.51.0301120943210.4564@filesrv1.baby-dragons.com>
References: <1042314720.1225.4.camel@sun>
	<20030111.212056.607951684.rene.rebe@gmx.net>
	<Pine.LNX.4.51.0301120943210.4564@filesrv1.baby-dragons.com>
X-Mailer: Mew version 2.2 on XEmacs 21.4.10 (Military Intelligence)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Hm - for me the different throughputs are a nice initial benchmark
... - I like them being printed out.

On: Sun, 12 Jan 2003 09:44:44 -0500 (EST),
    "Mr. James W. Laferriere" <babydr@baby-dragons.com> wrote:
> 
> 	Hello Rene , All ,  How about just printing the algorithm that is
> 	chosen & not the others ?  Just an idea .  JimL
> 
> On Sat, 11 Jan 2003, Rene Rebe wrote:
> > Hi.
> > In the case s.o. wants to pull the patch:
> > http://www.rocklinux.org/sources/package/base/linux24/82-raid5-niceer-output.patch
> > It is only a one-liner. It is not really nice since I print the
> > "writing arround L2 cache" text when XOR_SELECT_TEMPLATE is defined -
> > this might also be the case for an later AlitVec version for PowerPC
> > or so. So we might want a more generic text - or a text in the
> > appropriated .h file whetre XOR_SELECT_TEMPLATE is defined ...
> -- 
>        +------------------------------------------------------------------+
>        | James   W.   Laferriere | System    Techniques | Give me VMS     |
>        | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
>        | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
>        +------------------------------------------------------------------+
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
