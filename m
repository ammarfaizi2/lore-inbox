Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbSK2QVc>; Fri, 29 Nov 2002 11:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbSK2QVc>; Fri, 29 Nov 2002 11:21:32 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:11972 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267101AbSK2QVb>; Fri, 29 Nov 2002 11:21:31 -0500
Date: Fri, 29 Nov 2002 14:28:42 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Randal, Phil" <prandal@herefordshire.gov.uk>
cc: "'Javier Marcet'" <jmarcet@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Exaggerated swap usage
In-Reply-To: <0EBC45FCABFC95428EBFC3A51B368C9501B02D@jessica.herefordshire.gov.uk>
Message-ID: <Pine.LNX.4.44L.0211291427120.15981-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2002, Randal, Phil wrote:

> Mem:  1031036K av, 1021140K used,    9896K free,       0K shrd,   80560K buff
> Swap: 1052216K av,    5064K used, 1047152K free                  627808K cached

> Swapping in these circumstances shows a pathological reluctance to shed
> cached pages.

You've got 1 GB of RAM and 5 MB of pages in swap. That's an
almost negligable quantity.

Also, if vmstat doesn't show any swapins, the data is just
sitting there in swap without ever being used ... quite
possible since many distros start up daemons that people
don't really use.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

