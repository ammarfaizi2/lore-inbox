Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130385AbRCBKRl>; Fri, 2 Mar 2001 05:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130386AbRCBKRb>; Fri, 2 Mar 2001 05:17:31 -0500
Received: from [62.172.234.2] ([62.172.234.2]:56371 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S130385AbRCBKRL>;
	Fri, 2 Mar 2001 05:17:11 -0500
Date: Fri, 2 Mar 2001 10:14:49 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: "J . A . Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2ac8 lost char devices
In-Reply-To: <Pine.LNX.4.10.10103012127050.4143-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.21.0103021014160.1338-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Mark Hahn wrote:

> > > > > > Well, somethig has broken in ac8, because I lost my PS/2 mouse and
> > > > > me too </aol>.
> > No luck.
> 
> it seems to be the mdelay(2) added to pc_keyb.c in -ac6.

are you sure? My bet is that it is to do with misc device registration as
I lost not just psaux but microcode device (which happens to be misc as
well)

Regards,
Tigran

