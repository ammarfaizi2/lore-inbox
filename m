Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274426AbRJQDaj>; Tue, 16 Oct 2001 23:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274434AbRJQDa3>; Tue, 16 Oct 2001 23:30:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23556 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274426AbRJQDaX>; Tue, 16 Oct 2001 23:30:23 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Q] pivot_root and initrd
Date: 16 Oct 2001 20:30:47 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9qiu17$mhh$1@cesium.transmeta.com>
In-Reply-To: <3BCCEA19.8080809@usa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3BCCEA19.8080809@usa.net>
By author:    Eric <ebrower@usa.net>
In newsgroup: linux.dev.kernel
>
> I've been doing some work to boot a 2.4.x linux system from onboard 
> flash and then change_root to an attached disk.
> 
> As the kernel documentation admonishes us to use pivot_root instead of 
> relying on the change_root facility (Documentation/initrd.txt: "Current 
> kernels still support it, but you should _not_ rely on its continued 
> availability") I have given it a shot with less than stellar results-- 
> perhaps someone (Warner?) could enlighten me on a few points:
> 
> 1) What is the current status of pivot_root from an initrd?  Is anyone 
> using it for this purpose, and is it being deprecated by the "union 
> mounts" mentioned in the bootinglinux-current document by Warner?
> 

Works great.  I use it in my SuperRescue CD for example; you can there
check out a complete, working example.

  ftp://ftp.kernel.org/pub/dist/superresuce/

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
