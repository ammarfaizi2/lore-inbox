Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310644AbSCPUnl>; Sat, 16 Mar 2002 15:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310642AbSCPUn1>; Sat, 16 Mar 2002 15:43:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32522 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310622AbSCPUmQ>; Sat, 16 Mar 2002 15:42:16 -0500
Subject: Re: Linux 2.4.19-pre3-ac1
To: MrChuoi@yahoo.com
Date: Sat, 16 Mar 2002 20:58:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020316190415.38CE14E534@mail.vnsecurity.net> from "MrChuoi" at Mar 17, 2002 02:14:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mLFj-000794-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SwapTotal:       65528 kB
> SwapFree:        65528 kB
> Committed_AS:    57252 kB

Ok at this point you have 64Mb of free swap, and at worse (absolutely worst
pure theory) have 57Mb committed

> LowTotal:       126856 kB
> SwapTotal:       65528 kB
> SwapFree:        63324 kB
> Committed_AS:   226160 kB

So you have 128Mb of RAM, 64Mb of swap, and if all pages are touched you
would need 226Mb of swap + ram (minus kernel overhead). Looks like the
machine is hovering on the edge

