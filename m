Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267739AbTAITfh>; Thu, 9 Jan 2003 14:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267740AbTAITfh>; Thu, 9 Jan 2003 14:35:37 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:22547 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267739AbTAITfh>; Thu, 9 Jan 2003 14:35:37 -0500
Date: Thu, 9 Jan 2003 19:44:17 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rotation.
In-Reply-To: <Pine.GSO.4.21.0301081120540.21171-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0301091943010.5660-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Where are you going to implement the rotation? At the fbcon or fbdev level?

We already have a hook for hardware acceleration in struct fb_ops.

> Fbcon has the advantage that it'll work for all frame buffer devices.

The fbdev level will have the functionalty but fbcon is the one that needs 
it.


