Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131789AbQK2R1C>; Wed, 29 Nov 2000 12:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131805AbQK2R0w>; Wed, 29 Nov 2000 12:26:52 -0500
Received: from 213-123-77-235.btconnect.com ([213.123.77.235]:30214 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S131789AbQK2R0f>;
        Wed, 29 Nov 2000 12:26:35 -0500
Date: Wed, 29 Nov 2000 16:58:04 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Hugh Dickins <hugh@veritas.com>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.GSO.4.21.0011291130460.14112-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011291654240.1306-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Alexander Viro wrote:
> Considering your previous workplace... How does official SVR{4,5} behave?

Under SCO UnixWare 7.1.1 you can happily write to devices in a readonly
mounted (vxfs) filesystem. You can also happily access(W_OK) them. Just
tried, right now (ok, it should have been obvious from the src but I trust
my hands more than my eyes :)

If I read the src right, AIX 4.3 and Monterey64 should do the same. OSR504
looks the same but Hugh knows it a lot better than me (he wrote most of
it!) so I defer to him to verify.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
