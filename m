Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280700AbRKLNc4>; Mon, 12 Nov 2001 08:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279982AbRKLNch>; Mon, 12 Nov 2001 08:32:37 -0500
Received: from xun0.sr.bham.ac.uk ([147.188.32.128]:17356 "HELO
	xun0.sr.bham.ac.uk") by vger.kernel.org with SMTP
	id <S280700AbRKLNcZ>; Mon, 12 Nov 2001 08:32:25 -0500
Date: Mon, 12 Nov 2001 13:32:22 +0000 (GMT)
From: Adam Mercer <ram@star.sr.bham.ac.uk>
X-X-Sender: ram@xune
To: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 linker failure:
In-Reply-To: <200111121301.NAA04842@dirty-bastard.pthbb.org>
Message-ID: <Pine.GSO.4.40.0111121330260.25189-100000@xune>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Jerrad Pierce wrote:

> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0x8ac9): undefined reference to `deactivate_page'
> drivers/block/block.o(.text+0x8b09): undefined reference to `deactivate_page'

This is a known problem with 2.4.14, either use 2.4.15pre3 of apply the
patch in

http://marc.theaimsgroup.com/?l=linux-kernel&m=100501094419342&w=2

Cheers

Adam

