Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275086AbRIYQQc>; Tue, 25 Sep 2001 12:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275083AbRIYQQW>; Tue, 25 Sep 2001 12:16:22 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49680 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S275082AbRIYQQK>; Tue, 25 Sep 2001 12:16:10 -0400
Date: Tue, 25 Sep 2001 13:16:19 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Pau Aliagas <linux4u@wanadoo.es>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.9-ac15 painfully sluggish
In-Reply-To: <Pine.LNX.4.33.0109251729270.1401-100000@pau.intranet.ct>
Message-ID: <Pine.LNX.4.33L.0109251315130.26091-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Pau Aliagas wrote:

> My impressions of the latest Alan's kernel are very bad, compared to
> 2.4.9-ac10 which I'm happily running in a Pentium III laptop with 128Mb
> RAM and 400Mb swap.
>
> It hardly touches swap (not at least in top) but the IDE disk never stops.
> If I run setiathome it's absolutely impossible to do anything at all.
> Large applications that take seconds to start now take minutes!!

Interesting, the VM changes done to -ac15 seem to have
improved performance for all reports I've received up
to now.

Could you give me some info on how much memory is being
used by the various caches (first lines of top) and maybe
a few lines of vmstat output ?

Lets try to fix this problem...

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

