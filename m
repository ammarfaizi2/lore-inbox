Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRC0Mzl>; Tue, 27 Mar 2001 07:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRC0Mzb>; Tue, 27 Mar 2001 07:55:31 -0500
Received: from 5-026.cwb-adsl.telepar.net.br ([200.193.164.26]:34313 "EHLO
	imladris.rielhome.conectiva") by vger.kernel.org with ESMTP
	id <S131246AbRC0MzW>; Tue, 27 Mar 2001 07:55:22 -0500
Date: Tue, 27 Mar 2001 09:54:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: robert@mpe.mpg.de
cc: linux-kernel@vger.kernel.org
Subject: Re: ISSUE: very slow (factor 100) 4-way 16GByte server, with 2.4.2
In-Reply-To: <200103271127.f2RBRO513723@robert2.mpe-garching.mpg.de>
Message-ID: <Pine.LNX.4.21.0103270953010.8261-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Robert Suetterlin wrote:

> ISSUE: very slow (factor 100) 4-way 16GByte server, with 2.4.2

Last time we saw this issue on the list it turned out that the
machine had wrong MTRR settings and setup a significant part of
its memory non-cachable.

For a 16-way machine, 100 times speed difference is exactly what
I would expect when all memory is setup as uncachable.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

