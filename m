Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSERQky>; Sat, 18 May 2002 12:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSERQkx>; Sat, 18 May 2002 12:40:53 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:62216 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S313300AbSERQkw>;
	Sat, 18 May 2002 12:40:52 -0400
To: Andre Hedrick <andre@linux-ide.org>
Cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ide cd/dvd with 2.4.19-pre8
In-Reply-To: <Pine.LNX.4.10.10205180238160.774-100000@master.linux-ide.org>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 18 May 2002 18:39:16 +0200
Message-ID: <yw1xg00pqukr.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> writes:

> The driver pulled your system back into safe data io ranges.
> Either your cable routing is poor, your power supply is marginal, possible
> but not likely (hardware combination does not like the odd or even cable
> grounding setup), regardless it did the correct thing.
> 
> The problem is a feature to prevent the driver from dropping out of DMA
> to PIO when it is better to down grade the transfer rate.
> 
> The next issue is whether your ATAPI is in DMA, and it should not be.
> The driver core does not use split dma engines yet.

I just tried connecting it to a cmd646 controller. It runs at full speed
but no dma because of cmd bugs. Is there a problem with the new pdc202xx
driver in 2.4.19 or is it somehow my fault?

-- 
Måns Rullgård
mru@users.sf.net
