Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933278AbWK3Jha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbWK3Jha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933168AbWK3Jha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:37:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933278AbWK3Jh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:37:29 -0500
Subject: Re: [RFC][PATCH] Mount problem with the GFS2 code
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Srinivasa Ds <srinivasa@in.ibm.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, fabbione@ubuntu.com, bunk@stusta.de,
       aarora@linux.vnet.ibm.com, aarora@in.ibm.com
In-Reply-To: <20061130011236.6ac60998.akpm@osdl.org>
References: <456EA5BF.6090304@in.ibm.com>
	 <20061130002934.829334a6.akpm@osdl.org>
	 <1164877538.3752.93.camel@quoit.chygwyn.com>
	 <20061130011236.6ac60998.akpm@osdl.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 09:30:46 +0000
Message-Id: <1164879046.3752.101.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-11-30 at 01:12 -0800, Andrew Morton wrote:
> On Thu, 30 Nov 2006 09:05:38 +0000
> Steven Whitehouse <swhiteho@redhat.com> wrote:
> 
> > Was there another
> > reason for not using the bio routines?
> 
> Just that it's a layering violation.
> 
> Could I commend to you the use of code comments for this sort of thing?

Ok. I'll take the patch, and then add a suitable comment. I'll make a
note to change it to use the bh based functions at some stage in the
future,

Steve.


