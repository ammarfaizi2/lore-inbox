Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTKZMSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 07:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTKZMSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 07:18:52 -0500
Received: from attila.bofh.it ([213.92.8.2]:42447 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261569AbTKZMSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 07:18:51 -0500
Date: Wed, 26 Nov 2003 12:05:19 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Hanasaki JiJi <hanasaki@hanaden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via kt600 based motherboard compatibility
Message-ID: <20031126110519.GC2501@wonderland.linux.it>
References: <3FC41800.2020400@hanaden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC41800.2020400@hanaden.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 26, Hanasaki JiJi <hanasaki@hanaden.com> wrote:

 >Asus A7V600
 >http://www.asus.com/prog/spec.asp?m=A7V600&langs=01
 >	- ADI AD1980 audio sound
 >	- eCom 3C940 gigabit ethernet
 >		does it have a driver?
 >		does it work on 10/100 too?
I bought this one two weeks ago. The gigaethernet port works well and
I'm using it at 10 Mbps half duplex with the sk98 driver. It has a built
in cable tester, but it's not supported by linux.
The sound card works too, but I had to transplant in my kernel an
updated driver from ALSA CVS. This is annoying because ALSA CVS cannot
easily be compiled standalone for a 2.6. kernel.
There are a few problems (currently being debugged) with the IDE adapter
if you do not use the APIC, be sure to enable it when building the
kernel.
I have no SATA hardware, but I remember reading that the controller is
supported.

-- 
ciao, |
Marco | [3290 l'48jB9jyWEdM]
