Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267617AbSLNOSg>; Sat, 14 Dec 2002 09:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbSLNOSg>; Sat, 14 Dec 2002 09:18:36 -0500
Received: from 5-048.ctame701-1.telepar.net.br ([200.193.163.48]:62340 "EHLO
	5-048.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267617AbSLNOSf>; Sat, 14 Dec 2002 09:18:35 -0500
Date: Sat, 14 Dec 2002 12:26:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: mdew <mdew@orcon.net.nz>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: rmap and nvidia?
In-Reply-To: <1039859196.771.18.camel@nirvana>
Message-ID: <Pine.LNX.4.50L.0212141225320.32283-100000@imladris.surriel.com>
References: <1039858571.559.15.camel@nirvana>  <20021214093831.GL9882@holomorphy.com>
 <1039859196.771.18.camel@nirvana>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2002, mdew wrote:
> On Sat, 2002-12-14 at 22:38, William Lee Irwin III wrote:
> > On Sat, Dec 14, 2002 at 10:36:10PM +1300, mdew wrote:
> > > nv.c: In function `nv_get_phys_address':
> > > nv.c:2182: warning: implicit declaration of function `pte_offset'
> > > nv.c:2182: invalid type argument of `unary *'
> >
> > Use pte_offset_map() with a corresponding pte_unmap().
>
> err pardon?

wli just gave you the information you need to create a patch
for the nvidia driver.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
