Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUGVXHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUGVXHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUGVXH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:07:29 -0400
Received: from pop.gmx.de ([213.165.64.20]:20907 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267353AbUGVXH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:07:28 -0400
X-Authenticated: #4399952
Date: Fri, 23 Jul 2004 01:16:05 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       rlrevell@joe-job.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary	Kernel
 Preemption Patch
Message-Id: <20040723011605.62995d78@mango.fruits.de>
In-Reply-To: <848056B606F178CF9FBDDAC2@[192.168.1.247]>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	<1090306769.22521.32.camel@mindpipe>
	<20040720071136.GA28696@elte.hu>
	<200407202011.20558.musical_snake@gmx.de>
	<1090353405.28175.21.camel@mindpipe>
	<40FDAF86.10104@gardena.net>
	<1090369957.841.14.camel@mindpipe>
	<20040721125352.7e8e95a1@mango.fruits.de>
	<848056B606F178CF9FBDDAC2@[192.168.1.247]>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004 10:25:07 +1200
Andrew McGregor <andrew@indranet.co.nz> wrote:

> It is a PCI bus issue.  You simply don't have enough PCI bus cycles 
> available to do what you want to do.  The resource you're running out of is 
> bus bandwidth, and there's nothing to be done about it, other than remove 
> the PCI gfx card from the system.
> 
> If you get another dualhead AGP graphics card (anything will do), the 
> problem should go away.  We have a developer who does lowlatency 
> multichannel sound stuff on a machine with a Matrox G450 dualhead card no 
> problem.  I expect my own system (Radeon 9800 Pro and M-Audio 1010LT audio) 
> would be fine dualhead too, although I only run it singlehead at the 
> moment.  The 1010LT is 10 channels in and out of 24-bit 96kHz audio and 
> works great down to 1.5ms buffers, so it is no small bus load itself.

Hi,

thanks for the advice. I have tried some more pci cards and a very slow Virge 64 or something actually reduced the problem. Not completely though. I think i'll get me one of those G450 dual head cards..  

Florian Schmidt

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

