Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266466AbSKLKkd>; Tue, 12 Nov 2002 05:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266553AbSKLKkd>; Tue, 12 Nov 2002 05:40:33 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:30218 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S266466AbSKLKkb>; Tue, 12 Nov 2002 05:40:31 -0500
Message-ID: <3DD0DC4D.AE8787F6@aitel.hist.no>
Date: Tue, 12 Nov 2002 11:47:41 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs API
References: <20021112013244.GF1729@mythical.michonline.com> <Pine.GSO.4.21.0211112039430.29617-100000@steklov.math.psu.edu> <20021112080417.GA11660@think.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> 
> On Mon, Nov 11, 2002 at 08:49:22PM -0500, Alexander Viro wrote:

> Hi Al,
> 
> It's good that you're trying to clean up the devfs code, but...
> 
> How many people are actually using devfs these days?  I don't like it
> myself, and I've had to add a fair amount of hair to fsck's
> mount-by-label/uuid code to deal with interesting cases such as
> kernels where devfs is configured, but not actually mounted (it
Either you use devfs, or you don't.  Why even support such
an odd case?  Those wanting devfs makes the transition once.

> changes what /proc/partitions exports).  So I'm one of those who have
> never looked all that kindly on devfs, which shouldn't come as a
> surprise to most folks.

I use devfs and likes it.  Perhaps the current _implementation_ is bad,
the _idea_ is certainly good.  Seeing only devices I actually have
is so much better than seeing all devices I possibly could
connect.  And it is updated automatically whenever something
is added to or removed from the machine.
A cleaner smaller devfs increase the chance of better
maintenance.

I also like having subdirectories instead of a flat /dev, but
that is of course doable with the old way too.

Helge Hafting
