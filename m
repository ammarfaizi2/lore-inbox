Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263904AbRFRKOX>; Mon, 18 Jun 2001 06:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263906AbRFRKON>; Mon, 18 Jun 2001 06:14:13 -0400
Received: from [213.97.184.209] ([213.97.184.209]:33160 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S263904AbRFRKOE>;
	Mon, 18 Jun 2001 06:14:04 -0400
Date: Mon, 18 Jun 2001 12:14:01 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Strange behaviour of swap under 2.4.5-ac15
Message-ID: <Pine.LNX.4.33.0106181150320.11843-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I've running 2.4.5-ac15 for almost a day (22 hours) and I found
some strange behaviour of the kswap, at least it was not present in
2.4.5-ac9. The swap memory increase with time as the cache dedicated
memory also increase, that is swapping process at a very fast rate, even
when no program is getting more memory. Is that the expected behaviour?
	An example, with no process running (just the usual daemons and
none of them getting extra memory) the command:

	free ; sleep 60; free

             total       used       free     shared    buffers     cached
Mem:        513416     393184     120232        364      63276     254576
-/+ buffers/cache:      75332     438084
Swap:       530104      14228     515876

             total       used       free     shared    buffers     cached
Mem:        513416     393192     120224        364      63276     258412
-/+ buffers/cache:      71504     441912
Swap:       530104      18064     512040

	Any idea?

	- german

-------------------------------------------------------------------------
German Gomez Garcia         | "This isn't right.  This isn't even wrong."
<german@piraos.com>         |                         -- Wolfgang Pauli


