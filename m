Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129847AbQK1Sdj>; Tue, 28 Nov 2000 13:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129932AbQK1Sd3>; Tue, 28 Nov 2000 13:33:29 -0500
Received: from 213-123-72-140.btconnect.com ([213.123.72.140]:20232 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129847AbQK1SdS>;
        Tue, 28 Nov 2000 13:33:18 -0500
Date: Tue, 28 Nov 2000 18:05:09 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.GSO.4.21.0011281233540.9313-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011281802290.1254-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Alexander Viro wrote:
> You know, in such cases usual course of actions is to remove the bloody
> thing. It's not used, it's not set to anything useful, semantics is
> fundamentally non-obvious, so Occam's Razor applies. Until somebody
> comes up with a reasonable use _and_ clear semantics... Trying to invent
> one simply because the field is there looks, erm, odd.

Yes, I agree and, like I said, there are other things to do still. It just
looked like "the field was added recently but no support for it so it may
be a 'must-have' item for 2.4.0" which is why I rushed to try and give it
some meaning.

At least one useful thing came out of this exercise -- I understand the fd
allocation (fs/file.c) routines now.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
