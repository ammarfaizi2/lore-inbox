Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130950AbRA0NeK>; Sat, 27 Jan 2001 08:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131613AbRA0NeA>; Sat, 27 Jan 2001 08:34:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44550 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130950AbRA0Ndy>;
	Sat, 27 Jan 2001 08:33:54 -0500
Date: Sat, 27 Jan 2001 14:33:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Matti Långvall 
	<matti.langvall@sorliden.ornskoldsvik.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Running 2.4.0-ac11
Message-ID: <20010127143348.D27929@suse.de>
In-Reply-To: <3A720485.58D656A4@sorliden.ornskoldsvik.com> <20010127015122.E23160@suse.de> <3A72921C.D013F074@sorliden.ornskoldsvik.com> <20010127121742.A27553@suse.de> <3A72CD7B.62402916@sorliden.ornskoldsvik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3A72CD7B.62402916@sorliden.ornskoldsvik.com>; from matti.langvall@sorliden.ornskoldsvik.com on Sat, Jan 27, 2001 at 02:30:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27 2001, Matti Långvall wrote:
> You're right, no more Busy inodes.

Good, so that was the cause.

> But magicdev is nice for us lazy people..

No, the _concept_ is nice for lazy people but the current magicdev is
not worth much. I know Alan has tinkered with a new version, hopefully
that will be much better. Most newer drives have real (but polled)
media notification event classes, which is a much better way to
accomplish what magicdev is trying to do.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
