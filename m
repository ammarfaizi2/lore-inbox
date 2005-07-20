Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVGTMv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVGTMv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 08:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVGTMv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 08:51:58 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:7596 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261193AbVGTMv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 08:51:57 -0400
Date: Wed, 20 Jul 2005 14:54:59 +0200
From: DervishD <lkml@dervishd.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB debouncing?
Message-ID: <20050720125459.GD89@DervishD>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <mailman.1121790540.24438.linux-kernel2news@redhat.com> <20050719122206.1b690f57.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050719122206.1b690f57.zaitcev@redhat.com>
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
> On Tue, 19 Jul 2005 18:24:25 +0200, DervishD <lkml@dervishd.net> wrote:
> >     I have a new MP3 player, and when I disconnect it from the USB
> > port, my logs says:
> > 
> >     <30>Jul 19 18:11:05 kernel: usb.c: USB disconnect on device 00:07.3-1 address 2
> >     <27>Jul 19 18:11:06 kernel: hub.c: connect-debounce failed, port 1 disabled
> > 
> >     What is that 'connect-debounce' for? Is the port damaged? Am I
> > doing anything wrong?
[...]
> In this case, when you're pulling the plug the hub receives a
> momentary reconnect, so the software things something else was plugged.
> I think perhaps the resistor harness is not good in the device,
> or perhaps something is wrong with the connector.

    The device has a flimsy connector which didn't make good electric
contact, that was the problem. I've returned the device and got a new
one with a different connector that works ok :) Thanks a lot for the
hint, I was assuming some kind of incompatibility or something like
that, and the problem was just electrical.

    Thanks :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
