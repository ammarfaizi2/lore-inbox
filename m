Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbQKEUZ0>; Sun, 5 Nov 2000 15:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbQKEUZR>; Sun, 5 Nov 2000 15:25:17 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:26386 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129692AbQKEUZD>;
	Sun, 5 Nov 2000 15:25:03 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011052024.eA5KOss97563@saturn.cs.uml.edu>
Subject: Re: Loadavg calculation
To: bobyetman@att.net
Date: Sun, 5 Nov 2000 15:24:54 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011050746090.634-100000@juryrig.worldnet.att.net> from "bobyetman@att.net" at Nov 05, 2000 07:55:40 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The other option we looked at, besides using loadavg, was using idle pct%,
> but if I read the source for top right, involves reading the entire
> process table to calculate clock ticks used and then figuring out how many
> weren't used.

The old "top" code did that; it was a bug. Get some newer code:
http://www.cs.uml.edu/~acahalan/procps/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
