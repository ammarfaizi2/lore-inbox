Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292890AbSBVS03>; Fri, 22 Feb 2002 13:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292902AbSBVS0T>; Fri, 22 Feb 2002 13:26:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45573 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292952AbSBVS0I>; Fri, 22 Feb 2002 13:26:08 -0500
Subject: Re: is CONFIG_PACKET_MMAP always a win?
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Fri, 22 Feb 2002 18:40:01 +0000 (GMT)
Cc: dank@kegel.com (Dan Kegel),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        zab@zabbo.net (Zach Brown)
In-Reply-To: <20020222180957.A16796@kushida.apsleyroad.org> from "Jamie Lokier" at Feb 22, 2002 06:09:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16eKbx-0002k2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >    Overhead: kernel does a full memcpy of the packet body to get it
> >    into the ring buffer, and my program does another to get it out.
> 
> I had a look at this about a year ago, and it seems there is no method
> provided to read the packets without copying them, if you need them in
> user space.

You can process them in the ring buffer. If you can't keep up then you
are screwed any way you look at it 8)
