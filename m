Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313132AbSEHLvt>; Wed, 8 May 2002 07:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSEHLvs>; Wed, 8 May 2002 07:51:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34829 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313161AbSEHLvr>; Wed, 8 May 2002 07:51:47 -0400
Subject: Re: [PATCH] 2.5.14 IDE 56
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 8 May 2002 13:10:52 +0100 (BST)
Cc: dwguest@win.tue.nl (Guest section DW),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3CD8E9D1.1010309@evision-ventures.com> from "Martin Dalecki" at May 08, 2002 11:03:13 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175QHU-0001Q6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> about it... and you know I'm evil... hmmm...
> well why just don't let it be like that. It's functionally somehow the
> responsibility of the /sbin/hotplug thing anyway...

How do you intend to order a sequence of I/O operations precisely against a 
partition table change driven from user space ? Thats one I can't see a nice 
answer for, and having a raid controller that can do on the fly volume
resizing/creation/deletion its not just a matter of curiosity
