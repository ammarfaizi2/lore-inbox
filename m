Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbTEFPyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTEFPyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:54:00 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:60087 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S263902AbTEFPxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:53:20 -0400
Subject: Re: [PATCH] kmalloc_percpu
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030505235758.25f769fc.akpm@digeo.com>
References: <20030505.211606.28803580.davem@redhat.com>
	 <20030505224815.07e5240c.akpm@digeo.com>
	 <20030505234248.7cc05f43.akpm@digeo.com>
	 <20030505.223944.23027730.davem@redhat.com>
	 <20030505235758.25f769fc.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052237149.25671.1.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 May 2003 09:05:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 23:57, Andrew Morton wrote:

> The disk_stats structure has an "in flight" member.  If we don't have proper
> locking around that, disks will appear to have -3 requests in flight for all
> time, which would look a tad odd.

For what it's worth, the disk stats patch that vendors have been
shipping forever with 2.4 (and that Christoph pushed into 2.4.20) has
this problem, so at least people will be used to it.

	<b

