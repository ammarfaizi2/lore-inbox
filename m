Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319131AbSIJOHO>; Tue, 10 Sep 2002 10:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319135AbSIJOHN>; Tue, 10 Sep 2002 10:07:13 -0400
Received: from angband.namesys.com ([212.16.7.85]:17792 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S319131AbSIJOHM>; Tue, 10 Sep 2002 10:07:12 -0400
Date: Tue, 10 Sep 2002 18:11:53 +0400
From: Oleg Drokin <green@namesys.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu, andre@linux-ide.org
Subject: Re: 2.5.34 BUG at kernel/sched.c:944 (partitions code related?)
Message-ID: <20020910181153.B1095@namesys.com>
References: <20020910175639.A830@namesys.com> <20020910140622.GX8719@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020910140622.GX8719@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 10, 2002 at 04:06:22PM +0200, Jens Axboe wrote:

> >    Now it does it in reverse like this:
> > hdb: host protected area => 1
> > hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
> > hdb: hdb1
> > hda: host protected area => 1
> > hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
> > hda: hda1 hda2 hda3 hda4 < hda5PANIC
> Kernel compiled with preempt support or not?

No.
green@angband:~/bk_work/reiser3-linux-2.5-work-t> grep PREEM .config
# CONFIG_PREEMPT is not set

Bye,
    Oleg
