Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbTHUD42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 23:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbTHUD42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 23:56:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48906 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262394AbTHUD4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 23:56:24 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Initramfs confusion
Date: 20 Aug 2003 20:55:53 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bi1fs9$4am$1@cesium.transmeta.com>
References: <200308161940.52579.gkajmowi@tbaytel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200308161940.52579.gkajmowi@tbaytel.net>
By author:    Garrett Kajmowicz <gkajmowi@tbaytel.net>
In newsgroup: linux.dev.kernel
>
> I am just begining to test out 2.6 with an eye on use by X-terminals without 
> hard drives or NFS. As such I am quite enthusiastic about initramfs.  After 
> much stumbling around I created a root image that I would like to test, 
> compiled into kernel and created image.
> 
> I am doing testing under VMWare with 2.88 MB floppy images (for testing 
> purposes), but lilo is barfing trying to write to a regular file as a raw 
> device (doesn't know how to handle device 0x0700).
> 
> I cannot use a real floppy because I do not have any 2.88 MB floppies
> 

I suggest using SYSLINUX instead for floppies.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
