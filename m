Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131315AbQKJUWb>; Fri, 10 Nov 2000 15:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQKJUWV>; Fri, 10 Nov 2000 15:22:21 -0500
Received: from Cantor.suse.de ([194.112.123.193]:8979 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130369AbQKJUWC>;
	Fri, 10 Nov 2000 15:22:02 -0500
Date: Fri, 10 Nov 2000 21:21:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Message-ID: <20001110212156.A4568@inspiron.suse.de>
In-Reply-To: <20001110205129.A4344@inspiron.suse.de> <Pine.LNX.3.95.1001110150021.5941A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1001110150021.5941A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Nov 10, 2000 at 03:07:46PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 03:07:46PM -0500, Richard B. Johnson wrote:
> It isn't a TCP/IP stack problem. It may be a memory problem. Every time
> sendmail spawns a child to send the file data, it crashes.  That's
> why the file never gets sent!

Sure that could be the case. You should be able to verify the kernel kills the
task with `dmesg`.

However Jeff said the problem happens over 400K and a 500K attachment shouldn't
really run any machine out of memory, so maybe this wasn't his same problem?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
