Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270818AbTHGUF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270823AbTHGUF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:05:59 -0400
Received: from proibm3.portoweb.com.br ([200.248.222.108]:56750 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S270818AbTHGUF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:05:58 -0400
Date: Thu, 7 Aug 2003 17:08:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Ken Moffat <ken@kenmoffat.uklinux.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc1 breaks dri in X-4.3.0
In-Reply-To: <Pine.LNX.4.56.0308072050120.9400@ppg_penguin>
Message-ID: <Pine.LNX.4.44.0308071708390.4303-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Aug 2003, Ken Moffat wrote:

>  Apologies if this is a known bug, I'm slightly lost following the list,
> and the only bug I can see mentioned seems to be in Alan's tree.
> 
>  I've just built 2.4.22-rc1 for my PIII (via chipset, radeon 7500), and
> rebuilt radeon.o from the X 4.3 release.  This combination worked with
> 2.4.22-pre7 (although with occasional X lock-ups).
> 
>  In X's log I can see that the radeon module fails to open
> /dev/dri/card0 (no such device) and therefore the module load fails.
> 
>  From dmesg I can see that agpgart detects the chipset and reports the
> aperture,  but there are zero [drm] messages following.

Does the DRM module get loaded?

Whats the output of insmod drm.o ? 

