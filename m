Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbUCVTLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbUCVTLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:11:15 -0500
Received: from 195.47.173.163.ip.tele2adsl.dk ([195.47.173.163]:36224 "EHLO
	localhost") by vger.kernel.org with ESMTP id S262269AbUCVTLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:11:13 -0500
Message-ID: <405F3A9C.3050307@diku.dk>
Date: Mon, 22 Mar 2004 20:12:28 +0100
From: Christoffer Hall-Frederiksen <hall@diku.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en, da
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Jens Axboe <axboe@suse.de>, Heikki Tuuri <Heikki.Tuuri@innodb.com>,
       linux-kernel@vger.kernel.org
Subject: Re: True  fsync() in Linux (on IDE)
References: <023001c4100e$c550cd10$155110ac@hebis> <20040322132307.GP1481@suse.de> <20040322151712.GB32519@merlin.emma.line.org>
In-Reply-To: <20040322151712.GB32519@merlin.emma.line.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> Jens Axboe schrieb am 2004-03-22:
> 
> 
>>There's no such thing as atomic writes bigger than a sector really, we
>>just pretend there is. Timing usually makes this true.

;)

> 
> If there is no such atomicity (except maybe in ext3fs data=journal or
> the upcoming reiserfs4 - isn't there?), then nobody should claim so. If
> the kernel cannot 100.00000000% guarantee the write is atomic, claiming
> otherwise is plain fraud and nothing else.
> 
> Some people bet their whole business/company and hence a fair deal of
> their belongings on a single data base, and making them believe facts
> that simply aren't reality is dangerous. These people will have very
> little understanding for sloppiness here. Linux has no obligation to be
> fast or reliable, but it MUST PROPERLY AND TRUTHFULLY state what it can
> guarantee and what it cannot guarantee.

Some databases (eg. oracle) can write a checksum for each database page 
to overcome this problem, as this is not just "a linux problem".


-- 
	Christoffer

	Topper Harley: Interesting perfume.
	Ramada Thompson: It's Vicks. I have a cold.
