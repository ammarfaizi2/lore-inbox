Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVALOwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVALOwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 09:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVALOwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 09:52:05 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:33666 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261203AbVALOv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 09:51:58 -0500
To: diegocg@gmail.com
CC: kinema@gmail.com, fuse-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
In-reply-to: <20050112153131.1f778264.diegocg@gmail.com> (message from Diego
	Calleja on Wed, 12 Jan 2005 15:31:31 +0100)
Subject: Re: [fuse-devel] Merging?
References: <loom.20041231T155940-548@post.gmane.org>
	<E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu>
	<E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <20050112153131.1f778264.diegocg@gmail.com>
Message-Id: <E1CojqJ-0001Mw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 12 Jan 2005 15:51:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -You could implement several "not-performance-critical" filesystems (fat,
>  isofs) with FUSE to avoid possible security issues. Give that nowadays 
>  usb sticks and cd/dvds are so common it'd be possible to modify a filesystem
>  on purpose to crash the kernel if a bug were found in those filesytems. With
>  FUSE that posibility decreases.

One of my pet ideas, is a userspace loopback mounter, which would use
UML to actually mount an image, and export the resulting filesystem
through FUSE to the host.

Brilliant isn't it?

Miklos

