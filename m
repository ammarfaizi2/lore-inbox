Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273500AbRIQG5w>; Mon, 17 Sep 2001 02:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273501AbRIQG5m>; Mon, 17 Sep 2001 02:57:42 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:42383 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S273500AbRIQG5f>; Mon, 17 Sep 2001 02:57:35 -0400
Date: Mon, 17 Sep 2001 09:57:47 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Forced umount (was lazy umount)
Message-ID: <20010917095744.C22640@niksula.cs.hut.fi>
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu> <3BA4D554.4030203@foogod.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA4D554.4030203@foogod.com>; from alex@foogod.com on Sun, Sep 16, 2001 at 09:37:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 09:37:40AM -0700, you [Alex Stewart] claimed:
> Alexander Viro wrote:
> 
> Actually, I personally would still like a 'umount -f' (or 'umount 
> --yes-I-know-what-Im-doing-and-I-really-mean-it-f' or whatever) that 
> actually works for something other than NFS.  In this age of 
> hot-pluggable (and warm-pluggable) storage it's increasingly annoying to 
> me that I should have to reboot the whole system to fix an otherwise 
> hot-fixable hardware problem just because some processes got stuck in a 
> disk-wait state before the problem was detected.
> 
> I want an operation that will:
> 
> 1. Interrupt/Abort any processes disk-waiting on the filesystem
> 2. Unmount the filesystem, immediately and always.
> 3. Release any filesystem-related holds on the underlying device.
> 4. Allow me to mount it again later (when problems are fixed).
> 
> Basically, I want a 'kill -KILL' for filesystems.

This gets my vote too...

It would be interesting to hear if there are large obstacles that make this
impossible or hard to implement or whether it's just that nobody has coded it
yet.


-- v --

v@iki.fi
