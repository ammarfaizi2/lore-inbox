Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130138AbQK2LVb>; Wed, 29 Nov 2000 06:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131092AbQK2LVV>; Wed, 29 Nov 2000 06:21:21 -0500
Received: from 62-6-231-191.btconnect.com ([62.6.231.191]:19460 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S130138AbQK2LVI>;
        Wed, 29 Nov 2000 06:21:08 -0500
Date: Wed, 29 Nov 2000 10:52:39 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.GSO.4.21.0011290421060.14112-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011291047080.841-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Alexander Viro wrote:
> Could you look for duplicates too?

will do. One useful finding so far -- trying simultaneous mke2fs /dev/sdX1
for X = {b,c,d,e,f} deadlocks the machine dead (and without kdb such death
was in vain). (each disk is 37G, RAM is 6G)

I know this is offtopic for this thread but not for this list.

I am continuing to pursue the corruption. Nothing yet.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
