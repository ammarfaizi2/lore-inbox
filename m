Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbTCaTYY>; Mon, 31 Mar 2003 14:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261811AbTCaTYX>; Mon, 31 Mar 2003 14:24:23 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:6248 "EHLO
	dyn9-47-17-83.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id <S261809AbTCaTYS>; Mon, 31 Mar 2003 14:24:18 -0500
Message-ID: <3E88920A.BB8987D3@us.ibm.com>
Date: Mon, 31 Mar 2003 11:07:55 -0800
From: Janet Morgan <janetmor@us.ibm.com>
Reply-To: janetmor@us.ibm.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: William Lee Irwin III <wli@holomorphy.com>, akpm@digeo.com,
       suparna@in.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] Retry based aio read - filesystem read changes
References: <20030305144754.A1600@in.ibm.com> <20030305150026.B1627@in.ibm.com> <20030305024254.7f154afc.akpm@digeo.com> <20030305174452.A1882@in.ibm.com> <3E8889B4.FB716506@us.ibm.com> <20030331191123.GB13178@holomorphy.com> <20030331141629.I20730@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

> On Mon, Mar 31, 2003 at 11:11:23AM -0800, William Lee Irwin III wrote:
> > Can you tell whether these are due to hash collisions or contention on
> > the same page?
>
> No, they're most likely waiting for io to complete.
>
> To clean this up I've got a patch to move from aio_read/write with all the
> parameters to a single parameter based rw-specific iocb.  That makes the
> retry for read and write more ameniable to sharing common logic akin to the
> wtd_ ops, which we need at the very least for the semaphore operations.
>
>                 -ben
>

Can you post the patch you're referring to?

Thanks,
-Janet


