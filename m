Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130061AbQLYDna>; Sun, 24 Dec 2000 22:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130423AbQLYDnV>; Sun, 24 Dec 2000 22:43:21 -0500
Received: from srv8-bnu.bnu.terra.com.br ([200.248.48.18]:51470 "EHLO
	srv8-bnu.bnu.terra.com.br") by vger.kernel.org with ESMTP
	id <S130061AbQLYDnI>; Sun, 24 Dec 2000 22:43:08 -0500
Date: Mon, 25 Dec 2000 01:10:06 -0200
From: Augusto César Radtke <radtke@conectiva.com>
To: "Marco d'Itri" <md@linux.it>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001225011006.A2620@conectiva.com>
Mail-Followup-To: Augusto César Radtke <radtke@conectiva.com>,
	"Marco d'Itri" <md@Linux.IT>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20001224170052.A223@wonderland.linux.it> <Pine.LNX.4.10.10012240941540.3972-100000@penguin.transmeta.com> <20001225005303.A205@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001225005303.A205@wonderland.linux.it>; from md@Linux.IT on Mon, Dec 25, 2000 at 12:53:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco d'Itri wrote:

> And I have another problem: I'm experiencing random hangs using X[1] with
> 2.4.0-test12. After a variable amount of time, some of the times I use X
> (I mostly use console) it just freezes hard (no caps lock activity).
> I'm not sure if this only happens while using X or it's just less
> frequent in console. -test9 works fine and I used it since it has been
> released with no ill effects.

This is probably the run_task_queue bug fixed in test13pre3.

	Augusto
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
