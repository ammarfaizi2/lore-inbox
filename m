Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131358AbQK2RgZ>; Wed, 29 Nov 2000 12:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131851AbQK2RgQ>; Wed, 29 Nov 2000 12:36:16 -0500
Received: from 213-123-77-235.btconnect.com ([213.123.77.235]:36870 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S131358AbQK2RgC>;
        Wed, 29 Nov 2000 12:36:02 -0500
Date: Wed, 29 Nov 2000 17:07:14 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Hugh Dickins <hugh@veritas.com>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.LNX.4.21.0011291654240.1306-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0011291705250.1306-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Tigran Aivazian wrote:

> On Wed, 29 Nov 2000, Alexander Viro wrote:
> > Considering your previous workplace... How does official SVR{4,5} behave?
> 
> Under SCO UnixWare 7.1.1 you can happily write to devices in a readonly
> mounted (vxfs) filesystem. You can also happily access(W_OK) them. Just
> tried, right now (ok, it should have been obvious from the src but I trust
> my hands more than my eyes :)

just for the benefit of linux-kernel listeners who may be unaware of what
SVR5 is, which Al mentioned. SCO UnixWare 7.x _is_ the official SVR5 or as
it is called in the boot message "System V Release 5 from SCO".

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
