Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSFWCqC>; Sat, 22 Jun 2002 22:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316962AbSFWCqC>; Sat, 22 Jun 2002 22:46:02 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:17388 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316961AbSFWCqB>; Sat, 22 Jun 2002 22:46:01 -0400
Date: Sat, 22 Jun 2002 21:46:02 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: sean darcy <seandarcy@hotmail.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: piggy broken in 2.5.24 build
In-Reply-To: <3D152513.8010801@hotmail.com>
Message-ID: <Pine.LNX.4.44.0206222143550.7338-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2002, sean darcy wrote:

> 20 gigs free. Aren't these big new disks great?

I somehow manage to fill them up just fine no matter how big they are ;)

> Glad it's not a build problem. Just wish I could figure out what kind of 
> problem it is.

Well, could you try to 

cd /opt/kernel/linux-2.5.24/arch/i386/boot/compressed
objcopy -O binary -R .note -R .comment -S /opt/kernel/linux-2.5.24/vmlinux 
_tmp_piggy

and see if that generates _tmp_piggy in that directory?

--Kai


