Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131409AbQK2SZu>; Wed, 29 Nov 2000 13:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131127AbQK2SZk>; Wed, 29 Nov 2000 13:25:40 -0500
Received: from 213-123-77-235.btconnect.com ([213.123.77.235]:1543 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S130304AbQK2SZg>;
        Wed, 29 Nov 2000 13:25:36 -0500
Date: Wed, 29 Nov 2000 17:57:04 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.LNX.4.10.10011290940070.11951-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011291753100.1306-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Linus Torvalds wrote:
> That still leaves the SCSI corruption, which could not have been due to
> the request issue. What's the pattern there for people?

Linus, I confess that at the time (when I reproduced this problem on my
SCSI-only 4way/6G machine) I did not realize the importance of observing
the pattern or even just saving the log. No, I was _not_ just being stupid
but rather it was _so_ easy to panic Linux at the time (for various
reasons) that this one looked like just "yet another panic" somewhere.

Now, I am trying hard (lots of kernel compiles, bonnies, diff -urN between
linux trees, cp -a linuxA linuxB etc etc) to reproduce it and I can't.

All I remember from memory was those messages about "freeing stuff not in
datazone" etc. They were the same messages as I had on an IDE system and
the same as Mohammad and others reported on the list recently.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
