Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267445AbSLLUHx>; Thu, 12 Dec 2002 15:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbSLLUHx>; Thu, 12 Dec 2002 15:07:53 -0500
Received: from 5-048.ctame701-1.telepar.net.br ([200.193.163.48]:36296 "EHLO
	5-048.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267445AbSLLUHv>; Thu, 12 Dec 2002 15:07:51 -0500
Date: Thu, 12 Dec 2002 18:15:15 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Pinning kernel memory
In-Reply-To: <1039712449.3df8c0c183dfe@rumms.uni-mannheim.de>
Message-ID: <Pine.LNX.4.50L.0212121814450.17748-100000@imladris.surriel.com>
References: <1039712449.3df8c0c183dfe@rumms.uni-mannheim.de>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, Thomas Schlichter wrote:

> I want to create a big area of unswappable, physical continuous kernel memory
> for hardware testing purposes. Currently I allocate the memory using
> alloc_pages(GFP_KERNEL, order) and after this I pin it using
> SetPageReserved(page) for each page.

Kernel memory is never swappable, so there is no need to "pin it".


Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
