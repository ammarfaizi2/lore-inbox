Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272467AbRI0L4E>; Thu, 27 Sep 2001 07:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272449AbRI0Lzy>; Thu, 27 Sep 2001 07:55:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44556 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272415AbRI0Lzm>; Thu, 27 Sep 2001 07:55:42 -0400
Subject: Re: Why is Device3Dfx driver (voodoo1/2) not in the kernel?
To: jmcmullan@linuxcare.com (Jason McMullan)
Date: Thu, 27 Sep 2001 13:00:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9ou9u4$ee6$1@localhost.localdomain> from "Jason McMullan" at Sep 27, 2001 04:28:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mZqU-0003kx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > then voodoo would be safe for user direct access.
> 
> 	Better stop that this minute Alan! You're starting
> to sound like those old KGI people, with their 'safe kernel
> drivers for video' spiel... ;^)

There are actually distinct similarities between some DRI drivers and what
Linus suggested the KGI people needed to be doing. Certain hardware isnt 
totally user safe (not on the extremes of the voodoo1 here) and the drivers
do small amounts of work to stop abuse. All mode changes, rendering
primitives and the like are however in userspace.

I firmly believe you can do X11 with 3D in windows, including partial 
occlusion of 3d windows on a 3dfx voodoo1 or voodoo2 card. 

Alan
