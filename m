Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262931AbTC1LZK>; Fri, 28 Mar 2003 06:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262955AbTC1LZK>; Fri, 28 Mar 2003 06:25:10 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:47369 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262931AbTC1LZI>; Fri, 28 Mar 2003 06:25:08 -0500
Date: Fri, 28 Mar 2003 12:36:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: greg@kroah.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <UTC200303281110.h2SBA1L24473.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303281219350.5042-100000@serv>
References: <UTC200303281110.h2SBA1L24473.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> Roman, Your questions are misguided.

Thanks for your trust. :-(

> A larger dev_t is infrastructure.
> A sand road that is turned into an asphalt road.
> 
> Nobody has to use this improved infrastructure.
> But many uses are conceivable.

The size of dev_t doesn't matter at all, what matters is how this number 
is managed and used. The kernel has somehow to generate a number for a 
device and tell the user about it, so that he can use it to access the 
device. This requires infrastructure and the actual size of this number is 
only a small detail in the whole picture. I want to know how the whole 
picture looks like, so could you please stop talking bullshit and answer 
my questions?

> I can imagine that there will be people wanting
> to take part of the available space for a universal
> hash of disk serial number or partition label or
> I don't know what, so that devices are addressable
> by content instead of path.

This won't happen, dev_t is the wrong place to encode such information.

bye, Roman

