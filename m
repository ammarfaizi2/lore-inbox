Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbUALFny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 00:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266059AbUALFny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 00:43:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:1743 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266058AbUALFnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 00:43:13 -0500
Date: Sun, 11 Jan 2004 21:42:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: torvalds@osdl.org, thomas@winischhofer.net, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Message-Id: <20040111214259.568cff35.akpm@osdl.org>
In-Reply-To: <200401112353.43282.gene.heskett@verizon.net>
References: <20040109014003.3d925e54.akpm@osdl.org>
	<3FFF79E5.5010401@winischhofer.net>
	<Pine.LNX.4.58.0401111502380.1825@evo.osdl.org>
	<200401112353.43282.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> However, since I've been running 2.6.1-mm1 here, using the rivafb with 
>  an elderly gforce2-mx2 32 megger, I've noted that when running 
>  kde-3.1.1a with 8 windows, and a couple of them have multimegabyte 
>  backdrops, the biggest one being that famous deep space shot from 
>  hubble of about 4 or 5 months back.  In any other kernel, switching 
>  to that window took about 12 seconds for the backdrop to be converted 
>  to 1600x1200x32 and drawn the first time and about 8 seconds for the 
>  next time.  But with this 2.6.1-mm1 kernel, that repeat window switch 
>  is so close to instant that I cannot see it being drawn.
> 
>  So as far as I'm concerned, this particular set of fb patches to 
>  rivafb *need* to stay in mainline.  I'd sure appreciate it, a bunch.

There are no significant fbdev patches in 2.6.1-mm1.  There is a DRM
update.
