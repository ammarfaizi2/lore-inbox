Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130205AbQKYArr>; Fri, 24 Nov 2000 19:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130281AbQKYAri>; Fri, 24 Nov 2000 19:47:38 -0500
Received: from slc807.modem.xmission.com ([166.70.6.45]:30476 "EHLO
        flinx.biederman.org") by vger.kernel.org with ESMTP
        id <S130162AbQKYArV>; Fri, 24 Nov 2000 19:47:21 -0500
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [patch] O_SYNC patch 3/3, add inode dirty buffer list support to ext2
In-Reply-To: <20001122112646.D6516@redhat.com> <20001122115424.A18592@vger.timpanogas.org> <20001123120135.D8368@redhat.com> <20001123130125.B23067@vger.timpanogas.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Nov 2000 16:32:56 -0700
In-Reply-To: "Jeff V. Merkey"'s message of "Thu, 23 Nov 2000 13:01:25 -0700"
Message-ID: <m1snohvtcn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> writes:

> Cool.  ORACLE is going to **SMOKE** on EXT2 with this change.

<Pessimism>

Hmm I don't see how ORACLE is going to **SMOKE**.
Last I looked ORACLE would need a query optimizer that always
would find the best possible index and much less overhead to **SMOKE**.

Last I looked table reads were 10x slower than file reads.

</Pessimism>

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
