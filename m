Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTJTH02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTJTHY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:24:26 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:8832 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262410AbTJTHWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:22:48 -0400
Date: Mon, 20 Oct 2003 08:22:59 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310200722.h9K7Mxkm000371@81-2-122-30.bradfords.org.uk>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, Larry McVoy <lm@bitmover.com>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, nikita@namesys.com,
       Pavel Machek <pavel@ucw.cz>, Justin Cormack <justin@street-vision.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vitaly Fertman <vitaly@namesys.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       axboe@suse.de
In-Reply-To: <20031019224952.GA7328@pegasys.ws>
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60>
 <20031019041553.GA25372@work.bitmover.com>
 <3F924660.4040405@namesys.com>
 <20031019083551.GA1108@holomorphy.com>
 <20031019224952.GA7328@pegasys.ws>
Subject: Re: Blockbusting news, results are in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is apparently missing is better handling of the
> uncorrectable errors.  Specifically the ability to pass the
> errors and warnings up to the OS for evaluation and for the
> OS to be able to request a block remap or to undo a block
> remap.

Why this suggestion keeping coming up, I have no idea.  If you take
the idea to it's extreme, it's basically saying that we should
off-load all processing on to the host.  Although there has been a
move towards dumb peripherals in recent years, (E.G. software modems),
I have seen almost no even vaguely convincing arguments other than
cost as to why they are superior, (lower latency has been mentioned
with regard to software modems - I fail to see the benefit, although I
suppose it might exist for games players).  Apart from some data
recovery applications, I don't see how it is possible to do anything
really useful simply by adding the ability to pass some warnings and
errors up to the OS, without giving the OS access to all of the data
that the drive firmware has access to.

Obviously drives with completely open and free firmware would be
great, but that is not likely to happen in the near future, so for the
time being, if you don't like the way drives handle defect management,
complain to the manufactuers.  I am satisfied with the way Maxtor
disks handle defect management, both Eric's explainations and my own
observations.

John.
