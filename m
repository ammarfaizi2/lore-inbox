Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132888AbRDJAfz>; Mon, 9 Apr 2001 20:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132889AbRDJAfp>; Mon, 9 Apr 2001 20:35:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24091 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132888AbRDJAfa>; Mon, 9 Apr 2001 20:35:30 -0400
Date: Tue, 10 Apr 2001 02:37:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Manfred Spraul <manfred@colorfullife.com>, geirt@powertech.no,
        linux-kernel@vger.kernel.org
Subject: Re: Serial port latency
Message-ID: <20010410023714.B1024@athlon.random>
In-Reply-To: <000401c0b319517fea9@local> <20010325231013.A34@(none)>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010325231013.A34@(none)>; from pavel@suse.cz on Sun, Mar 25, 2001 at 11:10:14PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2001 at 11:10:14PM +0000, Pavel Machek wrote:
> I've seen similar bugs. If you hook something on schedule_tq and forget
> to set current->need_resched, this is exactly what you get.

keventd fixes tq_scheduler case (tq_scheduler is dead).

Andrea
