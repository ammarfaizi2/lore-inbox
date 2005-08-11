Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVHKH0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVHKH0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 03:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVHKH0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 03:26:08 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:59876 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1030198AbVHKH0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 03:26:07 -0400
Date: Thu, 11 Aug 2005 09:29:29 +0200
From: DervishD <lkml@dervishd.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with usb-storage and /dev/sd?
Message-ID: <20050811072929.GD1223@DervishD>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <mailman.1123702259.29404.linux-kernel2news@redhat.com> <20050810160027.04360a78.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050810160027.04360a78.zaitcev@redhat.com>
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

    Hi Pete :)

 * Pete Zaitcev <zaitcev@redhat.com> dixit:
> On Wed, 10 Aug 2005 21:22:43 +0200, DervishD <lkml@dervishd.net> wrote:
> >     I'm not using hotplug currently so... how can I make the USB
> > subsystem to assign always the same /dev/sd? entry to my USB Mass
> > storage devices? [...]
> You cannot. Just mount by label or something...

    Mounting by label won't work, the problem is the /dev entry,
which changes every time.

> Better yet, install something like Fedora Core 4, which uses HAL,
> and forget about it. The fstab-sync takes care of the rest.

    Oh no, thanks, I've already used Fedora and it only reinforced my
feeling about distros: I prefer my do-it-yourself box ;)

    Thanks :)))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
