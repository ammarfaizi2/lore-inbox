Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131936AbQLQCuH>; Sat, 16 Dec 2000 21:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132058AbQLQCt6>; Sat, 16 Dec 2000 21:49:58 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:529 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S131971AbQLQCtc>; Sat, 16 Dec 2000 21:49:32 -0500
Date: Sun, 17 Dec 2000 03:18:14 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: stewart@neuron.com, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: kapm-idled : is this a bug?
Message-ID: <20001217031814.A11954@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.21.0012111315350.4808-100000@duckman.distro.conectiva> <Pine.LNX.4.10.10012111343570.2897-100000@localhost> <20001215234037.F9506@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001215234037.F9506@bug.ucw.cz>; from pavel@suse.cz on Fri, Dec 15, 2000 at 11:40:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I guess we should just put even normal idle thread to be visible in
> ps. It is cleaner design, anyway.

How about adding a flag to FLAGS, or a new letter in STATE in
/proc/pid/stat, to mean "this is an idle task"?

ps & top could easily by taught to recognise the flag.

-- Jamie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
