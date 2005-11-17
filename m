Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbVKQXpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbVKQXpe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVKQXpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:45:34 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:25312 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S965129AbVKQXpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:45:33 -0500
Date: Fri, 18 Nov 2005 00:45:10 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: X and intelfb fight over videomode
Message-ID: <20051117234510.GA3854@hardeman.nu>
References: <20051117000144.GA29144@hardeman.nu> <437BD8D9.9030904@gmail.com> <20051117014558.GA30088@hardeman.nu> <437C0BF2.4010400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <437C0BF2.4010400@gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Score: -2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 12:49:54PM +0800, Antonino A. Daplas wrote:
>Ignore the hack I mentioned in the previous thread.  Try this patch instead.

Didn't help, the messages remain the same (tried with vga=0x318 and 
video=intelfb:1024x768-32@60,mtrr=0 vga=0x318).

Boot:
intelfb: 00:02.0: Intel(R) 852GM, aperture size 128MB, stolen memory 8060kB
intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
intelfb: Initial video mode is 1024x768-32@60.
intelfb: Changing the video mode is not supported.
Console: switching to colour frame buffer device 128x48

Starting X:
mtrr: base(0xe0020000) is not aligned on a size(0x300000) boundary
[drm:drm_unlock] *ERROR* Process 2976 using kernel context 0

First time I switch from X to VC:
intelfb: Changing the video mode is not supported.
intelfb: ring buffer : space: 6024 wanted 65472
intelfb: lockup - turning off hardware acceleration

Other suggestions?

//David
