Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264397AbUFLAvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbUFLAvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUFLAvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:51:10 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:56200 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S264397AbUFLAvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:51:06 -0400
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Invalid module format ?
Date: Fri, 11 Jun 2004 17:51:15 -0700
User-Agent: KMail/1.6.52
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20040612003846.GA4275@werewolf.able.es>
In-Reply-To: <20040612003846.GA4275@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111751.15408.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon ,

Grab the latest offical nvidia driver 5336 , then patch it with the patch 
aviable from http://www.minion.de/nvidia.html ( there patch allows the nvidia 
driver to compile and work under gcc 3.4 ). 

You also may want to make sure your using the latest module-init-tools.


Matt H.



On Friday 11 June 2004 5:38 pm, J.A. Magallon wrote:
> Hi all...
>
> First of all, I'm aware of the 'ask the vendor' answer. I just would like
> the reasons.
>
> With gcc-3.4.1 cvs, the nvidia module is miscompiled or something.
> The same sources that build and install with gcc-3.3, now build and give
> me this:
>
> werewolf:~# modinfo nvidia
> filename:       /lib/modules/2.6.7-rc3-jam1/video/nvidia.ko
> license:        NVIDIA
> werewolf:~# modprobe nvidia
> FATAL: Error inserting nvidia
> (/lib/modules/2.6.7-rc3-jam1/video/nvidia.ko): Invalid module format
>
> syslog:
>
> Jun 12 02:35:44 werewolf kernel: No module found in object
>
> werewolf:~# cat /proc/version
> Linux version 2.6.7-rc3-jam1 (root@werewolf.able.es) (gcc version 3.4.1
> (Mandrakelinux (Cooker) 3.4.1-0.2mdk)) #1 SMP Fri Jun 11 01:49:52 CEST 2004
>
> Any idea ?
