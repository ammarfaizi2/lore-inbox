Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSKETU4>; Tue, 5 Nov 2002 14:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264967AbSKETU4>; Tue, 5 Nov 2002 14:20:56 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:10068 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264963AbSKETU4>; Tue, 5 Nov 2002 14:20:56 -0500
Date: Tue, 5 Nov 2002 14:27:18 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>,
       linux-kernel@vger.kernel.org, weissg@vienna.at,
       Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Problem with USB-OHCI (2.4.20-pre10-ac2) and Sony Picturebook PCG-C1MHP
Message-ID: <20021105142718.A25146@devserv.devel.redhat.com>
References: <20021105103602.7c1282fa.Manuel.Serrano@sophia.inria.fr> <3DC8068A.7020000@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC8068A.7020000@pacbell.net>; from david-b@pacbell.net on Tue, Nov 05, 2002 at 09:57:30AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 05 Nov 2002 09:57:30 -0800
> From: David Brownell <david-b@pacbell.net>

>  > usb-ohci.c: USB OHCI at membase 0xcf85a000, IRQ 9
>  > usb-ohci.c: usb-00:0f.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller
> 
> I think Pete Zaitcev had a patch for this.  Seems like recent
> incarnations of that silicon need modified init sequences.

No, it's nothing of the sort of thing. Most likely, Manuel's lappy
has broken $PIRQ table, or some other problem with interrupt router.
This is a case for Manfred.

-- Pete
