Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311635AbSCTPGv>; Wed, 20 Mar 2002 10:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311643AbSCTPGm>; Wed, 20 Mar 2002 10:06:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40458 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311635AbSCTPG1>; Wed, 20 Mar 2002 10:06:27 -0500
Subject: Re: make rpm is not documented
To: maftoul@esrf.fr (Samuel Maftoul)
Date: Wed, 20 Mar 2002 15:22:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <20020320154100.D21789@pcmaftoul.esrf.fr> from "Samuel Maftoul" at Mar 20, 2002 03:41:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nhv9-0002XX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Second stuff, make rpm don't work for me on suse's kernel.

Ask SuSE 8)

> Didn't yet watched what is the problem, but seems to be related with
> EXTRAVERSION or something like this.

At least some versions of the script didnt like multiple '-' symbols. 
Gerald Britton fixed this for 2.4.18

> I will have further look and will try to say as much as I can with my
> poor knowledge.

Basically the thing works with

make config/menuconfig/xconfig
if you use make menu/xconfig then run make oldconfig (I dont trust xconfig..)
make rpm

[wait.. wait.. wait.. ]

rpm --install

add to lilo.conf

enjoy

