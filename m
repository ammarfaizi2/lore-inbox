Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbQL0O5O>; Wed, 27 Dec 2000 09:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130200AbQL0O5H>; Wed, 27 Dec 2000 09:57:07 -0500
Received: from iris.kkt.bme.hu ([152.66.114.1]:24072 "HELO iris.kkt.bme.hu")
	by vger.kernel.org with SMTP id <S130108AbQL0O4x>;
	Wed, 27 Dec 2000 09:56:53 -0500
Date: Wed, 27 Dec 2000 15:26:25 +0100 (CET)
From: PALFFY Daniel <dpalffy@kkt.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: panic with squid's pinger
In-Reply-To: <Pine.LNX.4.21.0012201735020.11725-100000@iris.kkt.bme.hu>
Message-ID: <Pine.LNX.4.21.0012271520170.22931-100000@iris.kkt.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, PALFFY Daniel wrote:

> Reproducible panic when squid gets the first request. Always at the same
> place in the pinger process. test12, test13-pre3 fail, but test12 runs
> fine on another machine
...

Sorry for the RTFArchive question, I've just found the previous thread on
the topic (netfilter locking)... The UWSG archive search didn't find
anything for the search string "ip_frag_queue"... Was this oops the
fragmented ping case?

test13-pre4 with Alexey's latest patch seems to work fine.

--
Dani
			...and Linux for all.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
