Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312473AbSCUUPI>; Thu, 21 Mar 2002 15:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312474AbSCUUO7>; Thu, 21 Mar 2002 15:14:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38417 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312473AbSCUUOs>; Thu, 21 Mar 2002 15:14:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] zlib double-free bug
Date: 21 Mar 2002 12:14:33 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a7dev9$n51$1@cesium.transmeta.com>
In-Reply-To: <3C985A46.D3C73301@aitel.hist.no> <Pine.LNX.4.44.0203200943230.3615-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0203200943230.3615-100000@xanadu.home>
By author:    Nicolas Pitre <nico@cam.org>
In newsgroup: linux.dev.kernel
>
> On Wed, 20 Mar 2002, Helge Hafting wrote:
> 
> > Nicolas Pitre wrote:
> > 
> > > > Removable media?
> > > 
> > > Most if not all removable media are not ment to be used with JFFS2.
> > 
> > Nothing is _meant_ to be exploited either.  Someone could
> > create a cdrom with jffs2 (linux don't demand that cd's use iso9660)
> 
> But JFFS2 demands to be used with AN MTD device, not a block device.  And
> most MTD device, if not all of them, on which JFFS2 is used aren't
> removable.
> 

Isn't this whole discussion a bit silly?  If I'm not mistaken, we're
talking about a one-line known fix here...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
