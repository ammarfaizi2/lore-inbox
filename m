Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264891AbSJ3TXV>; Wed, 30 Oct 2002 14:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSJ3TXN>; Wed, 30 Oct 2002 14:23:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29964 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264891AbSJ3TXL>; Wed, 30 Oct 2002 14:23:11 -0500
Date: Wed, 30 Oct 2002 11:29:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] SCSI and FibreChannel Hotswap for linux 2.5.44-bk2
In-Reply-To: <1036007128.5141.119.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0210301127170.7614-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Oct 2002, Alan Cox wrote:
>
> On Wed, 2002-10-30 at 18:54, Steven Dake wrote:
> > This patch has been reviewed by Alan Cox, Greg KH, Christoph Hellwig, 
> > Patrick Mansfield, Rob Landly, Jeff Garzik, Scott Murray, James 
> 
> Glanced at briefly once, not reviewed.

I'm going to leave the merging of this to the scsi people, in particular 
James and Doug. My personal feeling right now is that it's not going in 
the feature freeze, but as a driver thing I'm also convinced that 
especially if vendors need it, they'll add it anyway - and drivers tend to 
be less "frozen" than core code anyway (by necessity: we've always had to 
accept new drivers even in stable series).

		Linus

