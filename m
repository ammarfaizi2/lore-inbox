Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbTCQQMj>; Mon, 17 Mar 2003 11:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbTCQQMj>; Mon, 17 Mar 2003 11:12:39 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:50274 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261744AbTCQQMi>; Mon, 17 Mar 2003 11:12:38 -0500
Date: Mon, 17 Mar 2003 16:25:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: phillip@lougher.demon.co.uk
cc: linux-kernel@vger.kernel.org, <dan@intrago.co.uk>
Subject: Re: PROBLEM: (kern.log) kernel BUG at shmem.c:486!
In-Reply-To: <E18uuS7-0002KU-0X@anchor-post-33.mail.demon.net>
Message-ID: <Pine.LNX.4.44.0303171621250.1176-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003 phillip@lougher.demon.co.uk wrote:
> Dan Searle wrote:
> >
> >Mar  7 16:13:16 censornet-halewood kernel: Neighbour tabe overflow.
> >Mar  7 16:13:21 censornet-halewood kernel: NET: 445 messages suppressed.
> >Mar  7 16:13:21 censornet-halewood kernel: Neighbour table overflow.
> >
> >Mar  7 18:44:48 censornet-halewood kernel: kernel BUG at shmem.c:486!
> >Mar  7 18:44:48 censornet-halewood kernel: invalid operand: 0000
> 
> The kernel BUG at shmem.c:486 is not the real bug, you've
> hit a kernel sanity check which has failed, because
> something beforehand has got the kernel in an fscked state.

I agree with Phillip, that BUG at shmem.c:486 is not one I've heard
of people hitting.  But you could easily hit it if memory is getting
corrupted: worth running memtest86 for the evening and overnight.

Hugh

