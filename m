Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSGUUp1>; Sun, 21 Jul 2002 16:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSGUUp1>; Sun, 21 Jul 2002 16:45:27 -0400
Received: from mail.s3.kth.se ([130.237.48.5]:23055 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S314325AbSGUUp0>;
	Sun, 21 Jul 2002 16:45:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: memory leak?
References: <Pine.LNX.4.44L.0207211118241.12241-100000@imladris.surriel.com>
	<yw1xwurptb1x.fsf@gladiusit.e.kth.se>
	<1027269224.17234.101.camel@irongate.swansea.linux.org.uk>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 21 Jul 2002 22:48:33 +0200
In-Reply-To: Alan Cox's message of "21 Jul 2002 17:33:44 +0100"
Message-ID: <yw1xadokdcym.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > This memory will be reclaimed when the system needs it.
> > 
> > Does this mean that free and /proc/meminfo are incorrect?
> 
> By its own definition proc/meminfo is correct. top could go rummaging in
> /proc/slabinfo but its questionable if it is meaningful to do so. The
> actually "out of memory" case for a virtual memory system is not "no
> memory pages free" nor "no memory or swap free" its closer to "working
> set plus i/o buffers exceeds memory size".

Why can't proc/meminfo report these caches as cached instead of plain
used?  Would that be incorrect somehow?

-- 
Måns Rullgård
mru@users.sf.net
