Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVLORvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVLORvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbVLORvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:51:49 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:19946 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750867AbVLORvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:51:48 -0500
Date: Thu, 15 Dec 2005 18:51:40 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Linux/m68k <linux-m68k@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
In-Reply-To: <20051215171645.GY27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0512151832270.1609@scrub.home>
References: <20051215085516.GU27946@ftp.linux.org.uk>
 <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Dec 2005, Al Viro wrote:

> So who should I put as the author?  You or Geert (or whatever attributions
> might have been in said big patch)?  Incidentally,  ADBREQ_RAW had leaked
> into mainline (sans definition) in 2.3.45-pre2, which was Feb 13 2000, i.e.
> more than 1.5 year before your commit, so there's quite a chunk of history
> missing...

I'd say Geert, but it probably comes from the Mac tree. Anyway, it 
wouldn't be such a bad idea to ask him first why it's in his postponed 
queue:

http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/POSTPONED/130-adbraw.diff

My guess it needs some ack from the ppc people.

bye, Roman
