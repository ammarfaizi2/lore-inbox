Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLAI3S>; Fri, 1 Dec 2000 03:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLAI26>; Fri, 1 Dec 2000 03:28:58 -0500
Received: from cliff.i-plus.net ([209.100.20.42]:4103 "HELO cliff.i-plus.net")
	by vger.kernel.org with SMTP id <S129210AbQLAI2u>;
	Fri, 1 Dec 2000 03:28:50 -0500
From: Lee Brown <leejr@i-plus.net>
To: tytso@mit.edu
Subject: Re: 9750 vs. blade3D gives freaky ttyS3 problem)
Date: Fri, 1 Dec 2000 02:56:08 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00112718343300.00131@darkstar> <20001130130552.B9218@trampoline.thunk.org> <00120102540600.00115@darkstar>
In-Reply-To: <00120102540600.00115@darkstar>
MIME-Version: 1.0
Message-Id: <00120102570801.00115@darkstar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 30 Nov 2000, tytso@mit.edu wrote:
 > At a guess, it's an IRQ conflict.  The Blade3D card may be trying to
 > use the same interrupt as the serial port, and that's probably what's
 > causing problems.
 
 1) You nailed it.   IRQ 3 was the culprit.  Why I  assumed my
 box was PnP compatible I don't know (I guess I'm an optimist), but  I will not
 be fooled again.
 
 2) Thanks for answering.  You just made my good guy list ;-)

-- 
Lee Brown Jr.
leejr@i-plus.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
