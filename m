Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSEXO7C>; Fri, 24 May 2002 10:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317170AbSEXO7C>; Fri, 24 May 2002 10:59:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16140 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317169AbSEXO7B>; Fri, 24 May 2002 10:59:01 -0400
Subject: Re: kernel 2.4.19-pre8 reboots instead of halt and 3com messages
To: hilbert@hjb-design.com
Date: Fri, 24 May 2002 16:19:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022154900.3cecd894c6f95@webmail.freedom2surf.net> from "hilbert@hjb-design.com" at May 23, 2002 01:55:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BGqL-0006YL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since I installed the 2.4.19-pre8 kernel on my Athlon 1,3 GHz machine.
> The machine wont halt and poweroff any more it just reboots.
> Systemhardware
> AMD Irongate chipset
> NVidia 2MX (nvidia drivers 2880)

The Nvidia drivers are not supported by the open source community. 

Firstly please boot without the Nvidia drivers getting loaded at all. If the
problem still occurs check you built both the old and new kernel with the
same APM options.
