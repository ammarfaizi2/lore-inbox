Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131830AbQK2Shw>; Wed, 29 Nov 2000 13:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131685AbQK2Shl>; Wed, 29 Nov 2000 13:37:41 -0500
Received: from 213-123-77-235.btconnect.com ([213.123.77.235]:9735 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S131127AbQK2Shc>;
        Wed, 29 Nov 2000 13:37:32 -0500
Date: Wed, 29 Nov 2000 18:08:59 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.LNX.4.21.0011291753100.1306-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0011291806020.1306-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Tigran Aivazian wrote:

> On Wed, 29 Nov 2000, Linus Torvalds wrote:
> > That still leaves the SCSI corruption, which could not have been due to
> > the request issue. What's the pattern there for people?

one more thing I remember when this happened:

a) lots of ld processes from kernel compilation were failing with ENOSPC
although df(1) was showing plenty of memory and I could manually "touch
ok" in the same filesystem just fine.

b) immediately restarting "make -j4 bzImage" would go on for quite a bit
and then hit the same set of .c files and "run out of space" again.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
