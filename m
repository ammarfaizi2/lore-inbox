Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319291AbSH2Sfb>; Thu, 29 Aug 2002 14:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319293AbSH2Sfb>; Thu, 29 Aug 2002 14:35:31 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:53683 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319291AbSH2Sfa>; Thu, 29 Aug 2002 14:35:30 -0400
Date: Thu, 29 Aug 2002 15:39:34 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: linux-kernel@vger.kernel.org, <akpm@zip.com.au>,
       Gerrit Huizenga <gerrit@us.ibm.com>,
       Hans-J Tannenberger <hjt@us.ibm.com>,
       Janet Morgan <janetmor@us.ibm.com>, Mike Anderson <andmike@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: 2.5.32 IO performance issues
In-Reply-To: <200208291820.g7TIKHA19433@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44L.0208291538470.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Badari Pulavarty wrote:

> I am having severe IO performance problems with 2.5.32 (2.5.31 works fine).
> I was wondering what caused this.
>
> As you can see, IO rate went from
>
> 		384MB/sec with 6% CPU utilization on 2.5.31
> 			to
> 		120MB/sec with 19% CPU utilization on 2.5.32
>
> Any idea ?

384 MB/s is suspiciously fast.  What kind of disk subsystem
do you have to achieve that speed ?

Or did 2.5.31 keep the dirty data in memory, instead of
writing it to disk ? ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

