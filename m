Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVADABX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVADABX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVACX5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:57:45 -0500
Received: from hera.kernel.org ([209.128.68.125]:7562 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262011AbVACX47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:56:59 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
Date: Mon, 3 Jan 2005 23:56:18 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <crcm32$nsv$1@terminus.zytor.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103213627.GS29332@holomorphy.com> <20050103215503.GX26051@parcelfarce.linux.theplanet.co.uk> <87oeg6t8t5.fsf@benpfaff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1104796578 24480 127.0.0.1 (3 Jan 2005 23:56:18 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 3 Jan 2005 23:56:18 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <87oeg6t8t5.fsf@benpfaff.org>
By author:    Ben Pfaff <blp@cs.stanford.edu>
In newsgroup: linux.dev.kernel
>
> Al Viro <viro@parcelfarce.linux.theplanet.co.uk> writes:
> 
> > Egads...  Just use %zd for size_t.
> 
> %zu?
> 

Right, %zu for size_t, %zd for ssize_t.

       -hpa
