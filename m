Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319201AbSIKJYk>; Wed, 11 Sep 2002 05:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319203AbSIKJYk>; Wed, 11 Sep 2002 05:24:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29420 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319201AbSIKJYj>; Wed, 11 Sep 2002 05:24:39 -0400
Date: Wed, 11 Sep 2002 11:29:23 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Francesco Rabbi <f.rabbi@selcom.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: FrameBuffer Radeon BUG?
In-Reply-To: <3D7F2450.26707.2060B8@localhost>
Message-ID: <Pine.NEB.4.44.0209111124000.26432-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002, Francesco Rabbi wrote:

> During compiling 2.4.19 on athlon arc I've read that "fbcon_radeon8" variable
> was declared but no used. No problem, all work properly, only a notice for
> future release.

Thanks for this report. Recent -ac kernels (kernels by Alan Cox that
include more experimental stuff) include a Radeonfb update where
fbcon_radeon8 is actually used (AFAIR it's a bug that it wasn't used) and
this change will most likely go into the 2.4 kernels in the future.

> Best regards,
> 	Francesco

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


