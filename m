Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSFWQ05>; Sun, 23 Jun 2002 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSFWQ04>; Sun, 23 Jun 2002 12:26:56 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.17]:643 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S317058AbSFWQ0z>; Sun, 23 Jun 2002 12:26:55 -0400
Date: Sun, 23 Jun 2002 12:32:14 -0400
From: sean darcy <seandarcy@hotmail.com>
Subject: Re: piggy broken in 2.5.24 build - not piggy; it was BINUTILS
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3D15F80E.3040401@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
References: <linux.kernel.Pine.LNX.4.44.0206222143550.7338-100000@chaos.physics.uiowa.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:

> 
> cd /opt/kernel/linux-2.5.24/arch/i386/boot/compressed
> objcopy -O binary -R .note -R .comment -S /opt/kernel/linux-2.5.24/vmlinux 
> _tmp_piggy
> 
> and see if that generates _tmp_piggy in that directory?
> 

It was objcopy. I got binutils-2.12.90.0.12 from ftp.kernel.org - just 
released. It now works.

Thanks for putting me on the right track.

jay


