Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbUJYItl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbUJYItl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbUJYIs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:48:29 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:29318 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261727AbUJYIp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:45:29 -0400
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.9-mm1 oops
Date: Mon, 25 Oct 2004 10:45:09 +0200
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200410231731.21778.l_allegrucci@yahoo.it> <200410241620.50438.l_allegrucci@yahoo.it> <200410242202.17981.l_allegrucci@yahoo.it>
In-Reply-To: <200410242202.17981.l_allegrucci@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410251045.09370.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 October 2004 22:02, Lorenzo Allegrucci wrote:
> On Sunday 24 October 2004 16:20, Lorenzo Allegrucci wrote:
> > On Sunday 24 October 2004 14:30, Jens Axboe wrote:
> > > On Sat, Oct 23 2004, Lorenzo Allegrucci wrote:
> > > > 
> > > > 100% reproducible with elevator=cfq
> > > 
> > > but not with the other io schedulers?
> > 
> > No, now I can reproduce it with the anticipatory scheduler too.
> 
> I've just got the same oops using XFS instead of ext3.

And disabling CONFIG_PREEMPT_BKL doesn't help.

-- 
I route therefore you are
