Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbQLOSOS>; Fri, 15 Dec 2000 13:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129597AbQLOSOJ>; Fri, 15 Dec 2000 13:14:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12344 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129538AbQLOSOE>; Fri, 15 Dec 2000 13:14:04 -0500
Date: Fri, 15 Dec 2000 18:43:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Mike Black <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001215184325.B17781@inspiron.random>
In-Reply-To: <20001215175632.A17781@inspiron.random> <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Dec 15, 2000 at 12:07:55PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 12:07:55PM -0500, Richard B. Johnson wrote:
> Current code makes perfect sense if you put a 'break;' after the last

Current code makes perfect sense also without the break. I guess that's a
strict check to try to catch bugs, but calling it "deprecated" is wrong, it
should only say "warning: make sure that's not a bug" (when -Wall is enabled).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
