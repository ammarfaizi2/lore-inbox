Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSLaPMP>; Tue, 31 Dec 2002 10:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSLaPMP>; Tue, 31 Dec 2002 10:12:15 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:55498 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262877AbSLaPMO>; Tue, 31 Dec 2002 10:12:14 -0500
Date: Tue, 31 Dec 2002 09:19:37 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Ben Collins <bcollins@debian.org>
cc: Erik Andersen <andersen@codepoet.org>, Adrian Bunk <bunk@fs.tum.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix 2.4.x ieee1394
In-Reply-To: <20021229165255.GE10180@hopper.phunnypharm.org>
Message-ID: <Pine.LNX.4.44.0212310918110.32469-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Dec 2002, Ben Collins wrote:

> > Sorry about that.  I missed a spot.  Here is the full fix:
> > 
> 
> Thanks. I commited my portion.

I don't consider myself in charge for 2.4 kbuild, but I'm pretty sure all 
of these fixes are wrong, they won't work when more than just the core 
(ieee1394.o) is built-in. Reverting to the old Makefile seems the easiest 
and obvious fix.

--Kai


