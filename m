Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310601AbSCPUiW>; Sat, 16 Mar 2002 15:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310622AbSCPUh4>; Sat, 16 Mar 2002 15:37:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29194 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310602AbSCPUhY>; Sat, 16 Mar 2002 15:37:24 -0500
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 16 Mar 2002 20:53:13 +0000 (GMT)
Cc: paulus@samba.org (Paul Mackerras), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203160953420.31850-100000@penguin.transmeta.com> from "Linus Torvalds" at Mar 16, 2002 10:06:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mLAv-00078I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We'll end up (probably five years from now) re-doing the thing to allow 
> four levels (so a tired old x86 would fold _two_ levels instead of just 
> one, but I bet they'll still be the majority), simply because with three 
> levels you reasonably reach only about 41 bits of VM space.

If you use ridiculously small page sizes. If your page size is 64K, which
is an awful lot saner for a big machine, then three levels is just fine.

Alan
