Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132824AbRDPBb6>; Sun, 15 Apr 2001 21:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132825AbRDPBbs>; Sun, 15 Apr 2001 21:31:48 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:41489 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132824AbRDPBbd>; Sun, 15 Apr 2001 21:31:33 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Can't free the ramdisk (initrd, pivot_root)
Date: 15 Apr 2001 18:31:09 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9bdi0t$tg4$1@cesium.transmeta.com>
In-Reply-To: <9bbfib$qu4$1@cesium.transmeta.com> <Pine.LNX.4.33.0104151251500.4284-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0104151251500.4284-100000@godzilla.spiteful.org>
By author:    Scott Murray <scott@spiteful.org>
In newsgroup: linux.dev.kernel
> 
> Indeed it is.  This fix for drivers/block/rd.c (excerpted from 2.4.3-ac6):
> 

This did the trick.  I bounced the patch to Linus, too.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
