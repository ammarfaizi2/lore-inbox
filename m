Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUDWXGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUDWXGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUDWXGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:06:11 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:27923 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261654AbUDWXGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:06:09 -0400
Date: Sat, 24 Apr 2004 00:06:07 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Bobby Hitt <Bob.Hitt@bscnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Graphics Mode Woes
In-Reply-To: <028501c4296f$74da0390$0900a8c0@bobhitt>
Message-ID: <Pine.LNX.4.44.0404240004520.5826-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've since gotten this working, thanks to the help of Dmitry Torokhov:
> -----
> This is what I have for my GeForce2 Go. Actually I think what hurts you is
> FB_VGA16, not RIVA.. Still, if you using vesa like I do there is no point
> compiling rivafb (and If you using nVIDIA's binary driver rivafb usually
> conflicts with it).

Makes sense since the vag16 uses a different pixel encoding method, planar 
verses packed pixels.

>  I had the wrong drivers loaded.. My question now is where would I have been
> able to disable the "native driver"? I don't recall seeing this in the
> .config file.

By native I meant the nVIDIA fbdev driver.

