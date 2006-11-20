Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933762AbWKTLgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933762AbWKTLgf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933861AbWKTLgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:36:35 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:37531 "EHLO
	extu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S933762AbWKTLge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:36:34 -0500
X-AuditID: d80ac287-9e993bb000006994-03-4561934208f4 
Date: Mon, 20 Nov 2006 11:36:50 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Francis Moreau <francis.moro@gmail.com>
cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org
Subject: Re: Re : vm: weird behaviour when munmapping
In-Reply-To: <38b2ab8a0611200330w17a84994ne3a0eed11ae4485c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611201135120.10479@blonde.wat.veritas.com>
References: <38b2ab8a0611171301pe16229ch441ec24c538b1998@mail.gmail.com> 
 <Pine.LNX.4.64.0611181340220.7193@blonde.wat.veritas.com>
 <38b2ab8a0611200330w17a84994ne3a0eed11ae4485c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Nov 2006 11:36:33.0869 (UTC) FILETIME=[216CCFD0:01C70C98]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Francis Moreau wrote:
> On 11/18/06, Hugh Dickins <hugh@veritas.com> wrote:
> >
> > split_vma decides which address range will use the newly allocated
> > vm_area_struct in such a way as to suit its own convenience, and
> 
> again I don't agree. I would say that do_munmap() decides which
> address range will use the new allocated vma object. split_vma() get
> this information through its parameter named "new_below".

Yes, you're right.

Hugh
