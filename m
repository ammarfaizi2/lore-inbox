Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271607AbRHZWH1>; Sun, 26 Aug 2001 18:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271608AbRHZWHR>; Sun, 26 Aug 2001 18:07:17 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:56326 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S271600AbRHZWHC>; Sun, 26 Aug 2001 18:07:02 -0400
Date: Mon, 27 Aug 2001 00:07:15 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Feyr Tlincail <feyr_t@hotmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops! iptables and kernel 2.4.5
In-Reply-To: <F1379BekWo76UaiRNhF00012c3c@hotmail.com>
Message-ID: <Pine.LNX.4.33.0108270006140.991-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Feyr Tlincail wrote:

> for a few months now my gateway box keeps Oops'ing under some circumstance 
> (i'm thinking when there's a lot of packets being passed back and forth). 
> the box is an HP Vectra VL2 4/66 (486 DX 66 mhz) with 16 megs of ram and a 
> 500 megs hard disk (150 swap). it has 2 network card (one 3com using driver 
> 3c509 and the other is a no name using module "ne"), both are ISA (no pci 
> bus at all). the connection to the net is an Alcatel Speedtouch Home modem 
> (ADSL) connected to eth1 (the "ne" card)

That is a bug in iptables. Upgrade the kernel to 2.4.8 - I have not seen 
a single crash after upgrading. The problem is in 2.4.5 - 2.4.7 IIRC.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
If a trainstation is the place where trains stop, what is a workstation?
--------------------------------- [ moffe at amagerkollegiet dot dk ] --

