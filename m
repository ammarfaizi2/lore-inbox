Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266064AbUALGex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 01:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUALGex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 01:34:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:49899 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266064AbUALGew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 01:34:52 -0500
Date: Sun, 11 Jan 2004 22:34:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: torvalds@osdl.org, thomas@winischhofer.net, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Message-Id: <20040111223443.16166e07.akpm@osdl.org>
In-Reply-To: <200401120121.12122.gene.heskett@verizon.net>
References: <20040109014003.3d925e54.akpm@osdl.org>
	<200401112353.43282.gene.heskett@verizon.net>
	<20040111214259.568cff35.akpm@osdl.org>
	<200401120121.12122.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> >There are no significant fbdev patches in 2.6.1-mm1.  There is a DRM
>  >update.
> 
>  Whatever it is, its pure speed on this system here, Andrew.  DRM? 
>  lemme see if thats even turned on.  Nope "# CONFIG_DRM is not set"
>  Doing a make xconfig, I see that if I turn it on, there is not a 
>  driver for my gforce2/nvidia, so I naturally turned it back off.
> 
>  I do have VIA and agpgart enabled just above it, and over in the 
>  framebuffer menu, support for framebuffer and nvidia/riva are both 
>  checked.
> 
>  Anyway, something has made a huge difference in window switching 
>  speeds here, someplace between 2.6.0-mm2 and 2.6.1-mm1.  I like it.

Beats me.  Doing that vmstat measurement which Vladis suggests would be
interesting.



