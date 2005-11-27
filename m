Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVK0F5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVK0F5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 00:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbVK0F5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 00:57:39 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:44812 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750877AbVK0F5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 00:57:38 -0500
Date: Sun, 27 Nov 2005 06:57:25 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Michael Frank <mhf@users.berlios.de>
Cc: David Brown <dmlb2000@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.14.tar.bz2 permissions
Message-ID: <20051127055725.GL11266@alpha.home.local>
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <20051126223921.E7EF31AC3@hornet.berlios.de> <9c21eeae0511261441j7e4cc7c7ya99daaf1e437cb2a@mail.gmail.com> <20051126225656.04D3D1AC3@hornet.berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126225656.04D3D1AC3@hornet.berlios.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2005 at 11:53:23PM +0100, Michael Frank wrote:
> charset="iso-8859-1"
> Content-Transfer-Encoding: 7bit
> Content-Disposition: inline
> On Saturday 26 November 2005 23:41, David Brown wrote:
> > > Check your umask and set it to 022 ;)
> >
> > it is, still comes up world read/write.
> 
> Sorry for my sleepy advise.
> 
> sudo umask 022
 ^^^^^^^^^^^^^^^

This one is not going to be useful, because it will only set the umask
for the shell launched by sudo.

> sudo tar jxf linux-2.6.14.1.tar.bz2 --no-same-permissions

Regards,
Willy

