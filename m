Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbUBFCkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 21:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUBFCkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 21:40:39 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:47048 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265335AbUBFCke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 21:40:34 -0500
Date: Thu, 5 Feb 2004 21:40:31 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: =?koi8-r?Q?=22?=Good Oleg=?koi8-r?Q?=22=20?= 
	<olecom.gnu-linux@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG]: kernel BUG at mm/swapfile.c:806! (2.6)
In-Reply-To: <E1AouoU-000Fke-00.olecom-gnu-linux-mail-ru@f6.mail.ru>
Message-ID: <Pine.LNX.4.44.0402052139160.8446-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, [koi8-r] "Good Oleg[koi8-r] "  wrote:

> Feb  6 02:26:27 gluon kernel: ------------[ cut here ]------------
> Feb  6 02:26:27 gluon kernel: kernel BUG at mm/swapfile.c:806!
> Feb  6 02:26:27 gluon kernel: invalid operand: 0000 [#1]
> Feb  6 02:26:27 gluon kernel: CPU:    0
> Feb  6 02:26:27 gluon kernel: EIP:    0060:[<c015c7c4>]    Tainted: PFS
                                                                      ^^^
> Feb  6 02:26:27 gluon kernel: EFLAGS: 00010246
> Feb  6 02:26:27 gluon kernel: EIP is at map_swap_page+0x34/0x60

Can you reproduce the problem without proprietary drivers loaded ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


