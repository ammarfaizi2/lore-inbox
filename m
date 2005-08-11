Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVHKHaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVHKHaY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 03:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbVHKHaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 03:30:24 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:45029 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1030200AbVHKHaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 03:30:23 -0400
Date: Thu, 11 Aug 2005 09:33:44 +0200
From: DervishD <lkml@dervishd.net>
To: Greg KH <greg@kroah.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with usb-storage and /dev/sd?
Message-ID: <20050811073344.GE1223@DervishD>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050810192243.GA620@DervishD> <20050810215032.GA27982@irc.pl> <20050810220616.GA918@DervishD> <20050810233144.GA6718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050810233144.GA6718@kroah.com>
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

    Hi Greg :)

 * Greg KH <greg@kroah.com> dixit:
> On Thu, Aug 11, 2005 at 12:06:16AM +0200, DervishD wrote:
> >  * Tomasz Torcz <zdzichu@irc.pl> dixit:
> > >  That's what udev is for.
> >     I know, but I use a 2.4.x kernel (which I didn't mention in my
> > original message, sorry O:)), and udev needs a 2.6.x kernel, am I
> > wrong?
> That is correct, udev needs 2.6.  So, with 2.4 you are on your own here,
> sorry.

    Any way of forcing usb-storage to assign a particular device to a
recently plugged USB gadget? Wait a minute: hotplug events *include*
the name of the assigned device, am I wrong? Then I can deal with the
issue...

    I'll post my solution to the list, if any ;)

    Thanks :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
