Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVEQHMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVEQHMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVEQHMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:12:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:31963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261274AbVEQHMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:12:21 -0400
Date: Tue, 17 May 2005 00:11:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 0/8] dlm: overview
Message-Id: <20050517001133.64d50d8c.akpm@osdl.org>
In-Reply-To: <20050516071949.GE7094@redhat.com>
References: <20050516071949.GE7094@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland <teigland@redhat.com> wrote:
>
>  These are the distributed lock manager (dlm) patches against 2.6.12-rc4
>  that we'd like to see added to the kernel.

Squawk.

Not only do I not know whether this stuff should be merged: I don't even
know how to find that out.  Unless I'm prepared to become a full-on
cluster/dlm person, which isn't looking likely.

The usual fallback is to identify all the stakeholders and get them to say
"yes Andrew, this code is cool and we can use it", but I don't think the
clustering teams have sufficent act-togetherness to be able to do that.

Am I correct in believing that this DLM is designed to be used by multiple
clustering products?  If so, which ones, and how far along are they?

Looking at Ted's latest Kernel Summit agenda I see

 Clustering

 	We need to make progress on the kernel integration of things
 	like message passing, membership, DLM etc.

 	We seem to have at least two comparable kernel-side offerings
 	(OpenSSI and RHAT's), as well as a need to hash out how user-space
 	plays into this.

 	(There is now a plan for a Clustering Summit prior to KS - need
 	to validate if this will be useful, still)

So right now I'm inclined to duck any decision making and see what happens
in July.  Does that sounds sane?  Is that Clustering Summit going to happen?

In the meanwhile I can pop this code into -mm so it gets a bit more
compile testing, review and exposure, but that wouldn't signify anything
further.

