Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUEaMtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUEaMtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 08:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264622AbUEaMtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 08:49:41 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7627 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264610AbUEaMtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 08:49:40 -0400
Message-Id: <200405310135.i4V1ZcaT022144@eeyore.valparaiso.cl>
To: Ryan Reich <ryanr@uchicago.edu>
cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Udev thinks my cdrom is a char device? 
In-Reply-To: Message from Ryan Reich <ryanr@uchicago.edu> 
   of "Sun, 30 May 2004 15:54:52 EST." <20040530205450.GA2747@ryanr> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sun, 30 May 2004 21:35:37 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Reich <ryanr@uchicago.edu> said:
> I don't use my CD-ROM drive too often, and in fact I think the last time I
> did was 4 April, to make a backup; at the time I was running 2.6.4, patched
> with supermount and bootsplash.  Now I run 2.6.5, and I find the following
> odd situation in /dev:
> 
> # ls -l /dev/hd*

[...]

> crw-rw-rw-    1 root     root      22,   0 May 30 15:41 /dev/hdc

Filesystem corruption of some kind (or somebody remade the device
wrongly). Kernel has nothing to do with it.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
