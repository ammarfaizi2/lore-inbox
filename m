Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276184AbRI1RVL>; Fri, 28 Sep 2001 13:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276185AbRI1RVA>; Fri, 28 Sep 2001 13:21:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6667 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276184AbRI1RUt>; Fri, 28 Sep 2001 13:20:49 -0400
Date: Fri, 28 Sep 2001 14:21:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <kuznet@ms2.inr.ac.ru>
Cc: <mingo@elte.hu>, <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>, <bcrl@redhat.com>, <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <200109281704.VAA04444@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33L.0109281420180.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001 kuznet@ms2.inr.ac.ru wrote:

> Please, explain who exactly obtains an advantage of looping.
> net_rx_action()? Do you see drops in backlog?

> net_tx_action()? It does not look critical.

Then how would you explain the 10% speed difference
Ben and others have seen with gigabit ethernet ?

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

