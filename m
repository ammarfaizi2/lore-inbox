Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSEGMfv>; Tue, 7 May 2002 08:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSEGMfu>; Tue, 7 May 2002 08:35:50 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:18447 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315430AbSEGMft>; Tue, 7 May 2002 08:35:49 -0400
Date: Tue, 7 May 2002 14:35:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <3CD7B826.7000000@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0205071426350.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2002, Martin Dalecki wrote:

> Well one question renames: Please name me one PCI based architecture
> which contains IDE support and does not contain any special host chip
> attached to the very same PCI bus as well.

Architectures which are not directly PCI based, but which can have have 
PCI bridges. On the other hand even on PCI based archs you don't
necessarily want to compile in ide support automatically, please leave
that to Eric's autoconf.

bye, Roman

