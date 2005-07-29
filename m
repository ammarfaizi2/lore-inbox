Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVG2Gwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVG2Gwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 02:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVG2Gwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 02:52:50 -0400
Received: from gate.perex.cz ([82.113.61.162]:43697 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262348AbVG2Gwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 02:52:49 -0400
Date: Fri, 29 Jul 2005 08:52:45 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Thorsten Knabe <linux@thorsten-knabe.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [Alsa-devel] Re: [2.6 patch] schedule obsolete OSS drivers for
 removal
In-Reply-To: <Pine.LNX.4.61.0507281636040.20815@tek01.intern.thorsten-knabe.de>
Message-ID: <Pine.LNX.4.61.0507290849050.8400@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de>
 <Pine.LNX.4.61.0507281636040.20815@tek01.intern.thorsten-knabe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Thorsten Knabe wrote:

> On Tue, 26 Jul 2005, Adrian Bunk wrote:
> 
> > This patch schedules obsolete OSS drivers (with ALSA drivers that
> > support the same hardware) for removal.
> 
> Hello Adrian.
> 
> I'm the maintainer of the OSS AD1816 sound driver. I'm aware of two 
> problems of the ALSA AD1816 driver, that do not show up with the OSS 
> driver:
> - According to my own experience and user reports audio is choppy with 
>   some VoIP Softphones like gnophone at least when used with the ALSA 
>   OSS emulation layer, whereas the OSS driver is crystal clear.
> - Users reported, that on some HP Kayak systems the on-board AD1816A was 
>   not properly detected by the ALSA driver or was detected, but there 
>   was no audio output. I'm not sure if the problem is still present in 
>   the current ALSA driver, as I do not own such a system.
> 
> Maybe the OSS driver should stay in the kernel, until those problems are 
> fixed in the ALSA driver.

The problem is that nobody reported us mentioned problems. We have no 
bug-report regarding the AD1816A driver. Perhaps, it would be a good idea 
to add a notice to the help file and/or driver that the ALSA driver should 
be tested and bugs reported to the ALSA bug-tracking-system.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
