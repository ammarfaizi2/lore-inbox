Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVA0LWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVA0LWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVA0LPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:15:51 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:39633 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262576AbVA0LBN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:01:13 -0500
Date: Thu, 27 Jan 2005 12:02:04 +0100
From: DervishD <lkml@dervishd.net>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Oliver Neukum <oliver@neukum.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: Re: USB API, ioctl's and libusb
Message-ID: <20050127110204.GA76@DervishD>
Mail-Followup-To: Johannes Erdfelt <johannes@erdfelt.com>,
	Oliver Neukum <oliver@neukum.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
References: <20050126122014.GF58@DervishD> <200501261440.38766.oliver@neukum.org> <20050126163811.GA259@DervishD> <20050126212411.GB21204@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050126212411.GB21204@sventech.com>
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

    Hi Johannes :)

 * Johannes Erdfelt <johannes@erdfelt.com> dixit:
> On Wed, Jan 26, 2005, DervishD <lkml@dervishd.net> wrote:
> >  * Oliver Neukum <oliver@neukum.org> dixit:
> > > You are supposed to use libusb.
> >     That's irrelevant, the program I was trying to fix uses libusb.
> > My question is about the preferred kernel interface, 'cause I don't
> > know if it's the ioctl one or the URB one (well, I'm calling 'URB'
> > interface the API that is implemented using URB's inside the kernel).
> ioctl() calls are for userspace only.

    I was pretty sure of that. My doubt was the other way round. I
was assuming that the functions in <linux/usb.h> were syscalls, that
they're not.

> It just so happens there is an ioctl() call that provides an URB like
> interface and an ioctl() call that provides a synchronous call to do
> a control message.

    Didn't knew about that... Thanks a lot for the info!. Is there
any documentation available for the ioctl USB interface to the
kernel? Any API guide or something like that?

    Thanks :)
     
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
