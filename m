Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132898AbRDYWlL>; Wed, 25 Apr 2001 18:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbRDYWlC>; Wed, 25 Apr 2001 18:41:02 -0400
Received: from nrg.org ([216.101.165.106]:35106 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132898AbRDYWks>;
	Wed, 25 Apr 2001 18:40:48 -0400
Date: Wed, 25 Apr 2001 15:40:45 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: linux-kernel@vger.kernel.org
Subject: Re: #define HZ 1024 -- negative effects?
In-Reply-To: <3AE60A3D.9090103@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.05.10104251525130.4843-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001, Michael Rothwell wrote:
> Are there any negative effects of editing include/asm/param.h to change 
> HZ from 100 to 1024? Or any other number? This has been suggested as a 
> way to improve the responsiveness of the GUI on a Linux system. Does it 
> throw off anything else, like serial port timing, etc.?

Why not just run the X server at a realtime priority?  Then it will get
to respond to existing events, such as keyboard and mouse input,
promptly without creating lots of superfluous extra clock interrupts.
I think you will find this is a better solution.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

