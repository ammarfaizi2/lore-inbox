Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbSI0SYo>; Fri, 27 Sep 2002 14:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbSI0SYn>; Fri, 27 Sep 2002 14:24:43 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:52374 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262561AbSI0SYl>; Fri, 27 Sep 2002 14:24:41 -0400
Date: Fri, 27 Sep 2002 15:29:37 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Jens Axboe <axboe@suse.de>, Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Warning - running *really* short on DMA buffers while doing file
 transfers
In-Reply-To: <2483176224.1033147178@aslan.btc.adaptec.com>
Message-ID: <Pine.LNX.4.44L.0209271528540.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002, Justin T. Gibbs wrote:

> FreeBSD has several algorithms in its VM to prevent a single process
> from holding onto too many dirty buffers.  FreeBSD, Solaris, True64,
> even WindowsNT have effective algorithms for sanely retiring dirty
> buffers without saturating the system.

I guess those must be bad for dbench, bonnie or other critical
server applications ;)

*runs like hell*

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

