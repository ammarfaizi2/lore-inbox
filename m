Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131708AbQK2RUC>; Wed, 29 Nov 2000 12:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131761AbQK2RTw>; Wed, 29 Nov 2000 12:19:52 -0500
Received: from [62.172.234.2] ([62.172.234.2]:10137 "EHLO
        localhost.localdomain") by vger.kernel.org with ESMTP
        id <S131708AbQK2RTq>; Wed, 29 Nov 2000 12:19:46 -0500
Date: Wed, 29 Nov 2000 16:48:52 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: Alexander Viro <viro@math.psu.edu>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.LNX.4.21.0011291612190.1306-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0011291640140.4594-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Tigran Aivazian wrote:
> 
> The classical interpretation of the access(2) system call is "do the same
> type of permission check as open(2) would do but using real uid in the
> credentials instead of effective (or on Linux fs) uid".
....
> All I am saying is that if open on HP/UX allows writing but access denies
> it, it is definitely a bug (in HP/UX).

Oh, I agree fervently with you and Al on this,
just felt my opinion could be left out of it.

Hugh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
