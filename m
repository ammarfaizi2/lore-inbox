Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271919AbTG2RWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271929AbTG2RWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:22:40 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:40197 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271919AbTG2RWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:22:38 -0400
Date: Tue, 29 Jul 2003 18:22:36 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Groove Over <groove.over@blankenese.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: rivafb
In-Reply-To: <20030729102432.58cf7d21.groove.over@blankenese.de>
Message-ID: <Pine.LNX.4.44.0307291818081.5874-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi...
> The rivafb and the nvidia-accelerated drivers conflict, yes, but you can own situation if you tell X to use the rivafb-framebuffer instead the nvidia-one.
Not a surprise there :-(

> Section "Device"
>         Identifier      "GeForce"
>         Driver          "nvidia"
>         BusID           "1:0:0"
>         Option          "UseFBDev"      "true"
> EndSection
> 
> This should fix the problem.

This  works out most problems between X and fbdev. 
 
> And, I have my own question, too... How do I switch my resolution?
> 
> "kernel /boot/gentoo-2.4.20-r5-bo.nvidia root=/dev/hda3 video=rivafb:1280x1024-32@100" doesn't work for me.
> What is wrong? 

Bug in the software. I need to fix that. Right now  I'm working on its 
hardware cursor which is messed up.


