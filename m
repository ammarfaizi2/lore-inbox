Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291314AbSBVCT2>; Thu, 21 Feb 2002 21:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291312AbSBVCTS>; Thu, 21 Feb 2002 21:19:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10509 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291314AbSBVCTG>; Thu, 21 Feb 2002 21:19:06 -0500
Subject: Re: is CONFIG_PACKET_MMAP always a win?
To: dank@kegel.com
Date: Fri, 22 Feb 2002 02:33:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        zab@zabbo.net (Zach Brown)
In-Reply-To: <3C75A418.2C848B3F@kegel.com> from "Dan Kegel" at Feb 21, 2002 05:51:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16e5WA-0000Zt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> c) enable CONFIG_PACKET_MMAP, use PACKET_RX_RING, and read packets from an mmap'd ring buffer
>    Overhead: kernel does a full memcpy of the packet body to get it
>    into the ring buffer, and my program does another to get it out.

Why are you copying it out of the ring not processing it in place ?
