Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRCAN5F>; Thu, 1 Mar 2001 08:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRCAN4z>; Thu, 1 Mar 2001 08:56:55 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:26129 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129534AbRCAN4m>; Thu, 1 Mar 2001 08:56:42 -0500
From: flatmax <flatmax@cse.unsw.EDU.AU>
To: linux-kernel@vger.kernel.org
Date: Fri, 2 Mar 2001 00:56:38 +1100 (EST)
Subject: bzImage & L2 cache hang @ 'LILO loading Linux...'
Message-ID: <Pine.GSO.4.21.0103020054330.2085-100000@mozart.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

booting a compiled kernel ...
When I compile using bzImage (bzlilo), my computer hangs at 'LILO loading
Linux'
When I compile using zImage (zlilo), my computer boots just fine.

This sux 'cause I have to keep my kernel really small < 500 K to use zlilo

I can use bzImage IF AND ONLY IF I disable L2 cache in the bios. If I do
this then it boots fine.

Any known solutions ?

Matt



