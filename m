Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRDBWOk>; Mon, 2 Apr 2001 18:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDBWOa>; Mon, 2 Apr 2001 18:14:30 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:25559 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S131376AbRDBWO0>;
	Mon, 2 Apr 2001 18:14:26 -0400
Date: Tue, 3 Apr 2001 00:13:45 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [QUESTION] 2.4.x nice level
Message-ID: <Pine.A41.4.31.0104030003510.79632-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I just noticed, that a process with nice level 19, gets some processor
time, even if there is another process, which would use all of the
processor time.
for example, there is a setiathome running at nice level 19, and a
bladeenc at nice level 0. setiathome uses 14 percent, and bladeenc uses 84
percent of the processor. I think, setiathome should use max 2-3 percent.
the 14 percent is way too much for me.
or is there any other way to run a process only if nothing uses the
processor?
with kernel 2.2.16 it worked for me.
now I use 2.4.2-ac20

Bye,
Szabi


