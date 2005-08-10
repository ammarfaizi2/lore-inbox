Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVHJWCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVHJWCy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVHJWCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:02:53 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:57546 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932375AbVHJWCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:02:53 -0400
Date: Thu, 11 Aug 2005 00:06:16 +0200
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with usb-storage and /dev/sd?
Message-ID: <20050810220616.GA918@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050810192243.GA620@DervishD> <20050810215032.GA27982@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050810215032.GA27982@irc.pl>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Tomasz :)

 * Tomasz Torcz <zdzichu@irc.pl> dixit:
> On Wed, Aug 10, 2005 at 09:22:43PM +0200, DervishD wrote:
> >     The problem is that if I plug my USB memory, unplug it and plug
> > my MP3 player, it gets /dev/sdb this time, not /dev/sda. The mess is
> > even greater if I plug my card reader, which has four LUN's...
>  That's what udev is for.

    I know, but I use a 2.4.x kernel (which I didn't mention in my
original message, sorry O:)), and udev needs a 2.6.x kernel, am I
wrong?

>  Go figure how to udev-enable your distribution.

    I have a do-it-yourself Linux box, so setting up udev is not much
of a problem as long as the kernel supports it. If udev doesn't use
any kernel magic (that is, it only uses /sbin/hotplug), how the heck
does it know which /dev/sd? the *kernel* assigned to my recently
plugged USB device? How can it influenciate which device is assigned
*by the kernel*? I assume that it needs some magic from the kernel
and so it only works for 2.6.x :???? In fact, if it uses sysfs, it
still needs a 2.6.x for that, am I wrong?

    I'll take a look anyway, thanks a lot for your message and help :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
