Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131963AbQKWNXa>; Thu, 23 Nov 2000 08:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132280AbQKWNXT>; Thu, 23 Nov 2000 08:23:19 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:31756 "EHLO mailhost.tue.nl")
        by vger.kernel.org with ESMTP id <S131963AbQKWNXA>;
        Thu, 23 Nov 2000 08:23:00 -0500
Message-ID: <20001123135252.A4149@win.tue.nl>
Date: Thu, 23 Nov 2000 13:52:52 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>, "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <3A1CB07C.CEE01F1F@haque.net> <14876.45844.670274.366687@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <14876.45844.670274.366687@notabene.cse.unsw.edu.au>; from Neil Brown on Thu, Nov 23, 2000 at 05:03:00PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 05:03:00PM +1100, Neil Brown wrote:

> Oh, good.  It's not just me and Tigran then.

You have it all backwards. It would be good if it were
just you and Tigran. Unfortunately it also hits me.

(I am reorganizing my disks, copying large trees from
one place to the other. Always doing a diff -r between
old and new before removing the old version.
Yesterday I had a diff -r showing that the old version
was corrupted and the new was OK. Of course a second
look showed that the old version also was OK, the corruption
must have been in the buffer cache, not on disk.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
