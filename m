Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLYREn>; Mon, 25 Dec 2000 12:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129799AbQLYREd>; Mon, 25 Dec 2000 12:04:33 -0500
Received: from cicero0.cybercity.dk ([212.242.40.52]:63493 "HELO
	cicero0.cybercity.dk") by vger.kernel.org with SMTP
	id <S129595AbQLYRET>; Mon, 25 Dec 2000 12:04:19 -0500
Date: Mon, 25 Dec 2000 17:34:33 +0100
From: Jens Axboe <axboe@suse.de>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: test13-pre4... udf problem with dvd access vs test12
Message-ID: <20001225173433.I303@suse.de>
In-Reply-To: <3A47212D.F9F119C3@xmission.com> <3A476C7D.1952EDB4@haque.net> <3A477014.CE908BFC@haque.net> <20001225171305.G303@suse.de> <3A477333.1BC64D4C@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A477333.1BC64D4C@haque.net>; from mhaque@haque.net on Mon, Dec 25, 2000 at 11:17:55AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25 2000, Mohammad A. Haque wrote:
> Fix confirmed. Am i supposed to get some DriveSense errors? I probably
> am just don't recall.

Good. The whole idea of cdrom_log_sense is to be able to cleanly
limit the (often) sense-less (yes, haha :) ide-cd verbosity. Some of the
css stuff are obvious candidates. We want users to be aware of the
error, but often we end up flooding the logs with the same stuff over
and over again. This is often a source of confusion for the casual
user.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
