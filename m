Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbSKUO3Q>; Thu, 21 Nov 2002 09:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbSKUO3Q>; Thu, 21 Nov 2002 09:29:16 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:62341 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266686AbSKUO3Q>; Thu, 21 Nov 2002 09:29:16 -0500
Subject: Re: Too muxh paging with 2.4.20-rc2-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Max Valdez <maxvaldez@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1037827469.15147.8.camel@garaged.fis.unam.mx>
References: <1037827469.15147.8.camel@garaged.fis.unam.mx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 15:05:19 +0000
Message-Id: <1037891119.7845.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 21:24, Max Valdez wrote:
> Hi all !
> 
> I'm experiencing way too much paging with the 2.4.20-rc2-ac1 kernel.
> 
> Using vmware is almost prohibitive if i want to do anything else, in
> another scenario I'm right now compiling kdelibs, and "cvs'ing up" other
> modules and those two jobs are enough to stall for a few seconds my box
> every once in a while, on xosview i can see that there is a frecuent
> paging.
> 
> i'm on a 2 x pIII 800, 1GB RAM, using the attached .config for the
> latest ac patch.

The latest -ac has Rik's newer rmap code. It seems to have a few
problems so I may back it out again soon until Rik figures out the
problem

