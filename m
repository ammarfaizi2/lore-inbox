Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbRGPGYR>; Mon, 16 Jul 2001 02:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbRGPGYI>; Mon, 16 Jul 2001 02:24:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:19716 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267208AbRGPGX4>; Mon, 16 Jul 2001 02:23:56 -0400
To: linux-kernel@vger.kernel.org
From: Daniel Quinlan <quinlan@transmeta.com>
Subject: Re: cramfs
Date: 15 Jul 2001 23:23:52 -0700
Organization: Transmeta Corporation
Message-ID: <6yhewd8k93.fsf@sodium.transmeta.com>
In-Reply-To: <3B21A4F7.6040303@digitalme.com>
X-Trace: palladium.transmeta.com 995264632 1182 127.0.0.1 (16 Jul 2001 06:23:52 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 16 Jul 2001 06:23:52 GMT
Original-Sender: quinlan@transmeta.com
X-Newsreader: Gnus v5.7/Emacs 20.4
Cache-Post-Path: palladium.transmeta.com!unknown@sodium.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Trever L. Adams" <vichu@digitalme.com> writes:

> I hate to ask this, however here goes.  I am doing some remote upgrading 
> and some other really funky stuff to some boxes I keep up.
> 
> Part of these are total system upgrades and I need to move data out of 
> the way while still having a working box.  I decided that cramfs may be 
> the way to do this.  If you can tell me no and point me to a resource on 
> how to do this, I would LOVE to hear about it.
> 
> However, the question is, how can I tell lilo to tell the kernel too 
> boot off a cramfs file system?  I have already created the file with 
> /etc /bin /sbin /dev and /lib from a working system, doing the correct 
> deletions and other such changes.  I have a 15 meg cramfs that should do 
> the trick.
> 
> Thank you for any help you can offer.

You want "cramfsboot" to boot cramfs root partitions directly.
(You'll also need the cramfs patch which is part of the Midori Linux
kernel package.)

ftp://midori.transmeta.com/midori-1.0.0-beta2/apps/cramfsboot-0.2_ML1.0.0-beta2-5.mlz

(It's a tarball.)

There are also several packages that handle upgrades of cramfs
partitions, etc.

- Dan
