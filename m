Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264893AbSJVUM1>; Tue, 22 Oct 2002 16:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSJVULU>; Tue, 22 Oct 2002 16:11:20 -0400
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:64415 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S264887AbSJVUKP> convert rfc822-to-8bit; Tue, 22 Oct 2002 16:10:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan Dittmer <jan@jandittmer.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Tue, 22 Oct 2002 22:16:56 +0200
User-Agent: KMail/1.4.3
References: <200210190241.49618.jan@jandittmer.de> <20021020104601.C8606@ucw.cz> <20021020093818.GC24484@suse.de>
In-Reply-To: <20021020093818.GC24484@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210222216.56633.jan@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > There _may_ be issues with changing depth on the fly. So if you could
> > > just test without fiddling with changing depths that would be great.
> >
> > Ok. No changes in /proc using_tcq after boot, assuming it's enabled
> > automatically (checked that in kernel config0, it works perfectly fine.
>
> Thanks for verifying that! Jan, you appeared to have problems even with
> tcq-per-default enabled and not touching the depth while running io, is
> that correct?

Okay tested it for roughly a day, doing some heavy I/O. Seems to work fine. 
Didn't dare to change setting though. Had yet no time to test it with an 
older kernel.

ds666:/nfshome/jdittmer# cat /proc/ide/hda/settings | grep -i tcq
using_tcq               1               0               32              rw

jan
