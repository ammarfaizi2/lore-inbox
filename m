Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbTAHAr0>; Tue, 7 Jan 2003 19:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbTAHAr0>; Tue, 7 Jan 2003 19:47:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22921
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267616AbTAHArZ>; Tue, 7 Jan 2003 19:47:25 -0500
Subject: Re: Honest does not pay here ...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: venom@sns.it, Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <20030108003050.GF17310@work.bitmover.com>
References: <20030107232820.GB24664@merlin.emma.line.org>
	 <Pine.LNX.4.43.0301080059460.24706-100000@cibs9.sns.it>
	 <20030108003050.GF17310@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041990064.22457.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 08 Jan 2003 01:41:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 00:30, Larry McVoy wrote:
> 
> I may be showing my ignorance here (won't be the first time) but this makes
> me wonder if Linux could provide a way to do "user level drivers".  I.e.,
> drivers which ran in kernel mode but in the context of a process and had
> to talk to the real kernel via pipes or whatever.  It's a fair amount of
> plumbing but could have the advantage of being a more stable interface
> for the drivers. 

Its actually quite messy because level triggered interrupts create priority
handling problems and memory allocations create all sorts of amazing deadlocks

