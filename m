Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132219AbRATT4M>; Sat, 20 Jan 2001 14:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132222AbRATT4D>; Sat, 20 Jan 2001 14:56:03 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:61190 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132219AbRATTzq>;
	Sat, 20 Jan 2001 14:55:46 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101201939.WAA05326@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: andrea@suse.de (Andrea Arcangeli)
Date: Sat, 20 Jan 2001 22:39:36 +0300 (MSK)
Cc: mingo@elte.hu, torvalds@transmeta.com, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010120203023.A5274@athlon.random> from "Andrea Arcangeli" at Jan 20, 1 08:30:23 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So this mean if I do:

Yes. It is cost, which we have to pay. Look into Minshall's draft,
by the way (draft-minshall-nagle-*), it discusses pros and contras.

Much saner behaviour wrt latency (and perfect clarity) overweights
a bit worse coalescing.

Alexey

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
