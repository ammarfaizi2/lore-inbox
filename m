Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTKWSQv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTKWSQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 13:16:51 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:14210
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263378AbTKWSQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 13:16:50 -0500
Date: Sun, 23 Nov 2003 13:15:32 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Aubin LaBrosse <arl8778@rit.edu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DRI and AGP on 2.6.0-test9
In-Reply-To: <1069571959.9574.46.camel@rain.rh.rit.edu>
Message-ID: <Pine.LNX.4.53.0311231313110.2498@montezuma.fsmlabs.com>
References: <1069571959.9574.46.camel@rain.rh.rit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Nov 2003, Aubin LaBrosse wrote:

> Hi all, 
> 
> I'm having a problem with 2.6.0-test9 and DRI.  dmesg tells me:
> 
> [drm] Initialized radeon 1.9.0 20020828 on minor 0
> [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> [drm:radeon_unlock] *ERROR* Process 4113 using kernel context 0

For my curiosity, can you try compiling the Radeom/drm and AGP driver into 
the kernel?

> anyway, some more information:
> 
> this is a 2-cpu machine, AMD MP2000+'s on a Tyan Tiger MPX board
> (AMD-760MPX chipset ) 4xAGP, Radeon AIW (the original one, so i suspect
> 7200. certainly r200, which afaik requires no proprietary drivers at all
> for dri to work. Perhaps it is an smp issue?  anyway, here's my kernel
> config:

I just tried test9-mm5 with a radeon 9000 on an smp machine with the 
desired results.
