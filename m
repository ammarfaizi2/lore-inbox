Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRADBWU>; Wed, 3 Jan 2001 20:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRADBWL>; Wed, 3 Jan 2001 20:22:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24074 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129370AbRADBVz>;
	Wed, 3 Jan 2001 20:21:55 -0500
Date: Thu, 4 Jan 2001 02:21:19 +0100
From: Jens Axboe <axboe@suse.de>
To: William Stearns <wstearns@pobox.com>
Cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
        "Ts'o, Theodore -- Theodore Ts'o" <tytso@mit.edu>, tytso@valinux.com,
        Joel Koerwer <joel@ideacode.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Loopback filesystem still hangs on 2.4.0-test13-pre7
Message-ID: <20010104022119.B2408@suse.de>
In-Reply-To: <Pine.LNX.4.30.0101031202370.901-100000@sparrow.websense.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101031202370.901-100000@sparrow.websense.net>; from wstearns@pobox.com on Wed, Jan 03, 2001 at 01:09:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03 2001, William Stearns wrote:
> Good day, all,
> 	This is just meant as an informational message, not a complaint.
> Ted, could you note that this still exists on 2.4.0-test13-pre7 in the
> todo page?  Many thanks.
> 
> [1.] One line summary of the problem:
> 	Loopback filesystem writes still hang on 2.4.0-test13-pre7.

Could you try with this patch:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4-prerelease/loop-remap-2

it survives 10 runs of your script and dbench abuse etc. If there are still
problems, I'd like to know... Should be faster too :-)

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
