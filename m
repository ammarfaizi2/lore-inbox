Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRCZPfW>; Mon, 26 Mar 2001 10:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131644AbRCZPfM>; Mon, 26 Mar 2001 10:35:12 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:45585 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131614AbRCZPfA>; Mon, 26 Mar 2001 10:35:00 -0500
Date: Mon, 26 Mar 2001 11:48:30 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <l03130329b6e4c32df9a7@[192.168.239.101]>
Message-ID: <Pine.LNX.4.21.0103261146120.1863-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001, Jonathan Morton wrote:

> I have, however, found a bug in the non-overcommit patch - it seems to
> be capable of double-freeing (and then some) - starting 4 Java VMs and
> then closing them causes VMReserved to go negative on my system.

*grin*

It's nice to see the non-overcommit code being tested and
fixed like this. If there turns out to be a demand for this
patch, I guess we'll even want to integrate this into the
kernel ... possibly even the 2.4 kernel, if the code changes
are small/managable enough.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

