Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSGUVR1>; Sun, 21 Jul 2002 17:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSGUVR1>; Sun, 21 Jul 2002 17:17:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:8713 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S314083AbSGUVR0>; Sun, 21 Jul 2002 17:17:26 -0400
Date: Sun, 21 Jul 2002 18:08:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: memory leak?
In-Reply-To: <yw1xadokdcym.fsf@gladiusit.e.kth.se>
Message-ID: <Pine.LNX.4.44L.0207211807300.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jul 2002, Måns Rullgård wrote:

> Why can't proc/meminfo report these caches as cached instead of plain
> used?  Would that be incorrect somehow?

The kernel exports the usage statistics in /proc/meminfo
and /proc/slabinfo.  IMHO it's up to userland to present
this info in a meaningful way, no need to shove that piece
of functionality into the kernel.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

