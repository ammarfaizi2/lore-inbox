Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317838AbSFMXuC>; Thu, 13 Jun 2002 19:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317854AbSFMXuB>; Thu, 13 Jun 2002 19:50:01 -0400
Received: from mail-src.takas.lt ([212.59.31.78]:19633 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S317838AbSFMXuA>;
	Thu, 13 Jun 2002 19:50:00 -0400
Date: Fri, 14 Jun 2002 01:48:45 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[2]: Serverworks OSB4 in impossible state
To: Daniela Engert <dani@ngrt.de>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <20020613104659.37E7B109F6@mail.medav.de>
X-Mailer: Mahogany 0.64.2 'Sparc', compiled for Linux 2.4.18-rc4 i686
Message-ID: <ISPFE7tJZEkcDtTXrtf0000bf6d@mail.takas.lt>
X-OriginalArrivalTime: 13 Jun 2002 23:50:00.0472 (UTC) FILETIME=[07CAC980:01C21335]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002 13:50:25 +0200 (CDT) Daniela Engert <dani@ngrt.de> wrote:

> My conclusion: don't do ATAPI DMA on a serverworks ROSB4 revision 0 IDE
> controller.

How can I find revision? I have a problem with (Seagate) hdds, but lspci -v
only shows:

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
        Subsystem: ServerWorks OSB4 South Bridge
        Flags: bus master, medium devsel, latency 0


00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 2000 [size=16]


Regards,
Nerijus

