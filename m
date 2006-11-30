Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWK3JRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWK3JRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWK3JRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:17:07 -0500
Received: from smtp.osdl.org ([65.172.181.25]:25795 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932068AbWK3JRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:17:04 -0500
Date: Thu, 30 Nov 2006 01:12:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Srinivasa Ds <srinivasa@in.ibm.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, fabbione@ubuntu.com, bunk@stusta.de,
       aarora@linux.vnet.ibm.com, aarora@in.ibm.com
Subject: Re: [RFC][PATCH] Mount problem with the GFS2 code
Message-Id: <20061130011236.6ac60998.akpm@osdl.org>
In-Reply-To: <1164877538.3752.93.camel@quoit.chygwyn.com>
References: <456EA5BF.6090304@in.ibm.com>
	<20061130002934.829334a6.akpm@osdl.org>
	<1164877538.3752.93.camel@quoit.chygwyn.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 09:05:38 +0000
Steven Whitehouse <swhiteho@redhat.com> wrote:

> Was there another
> reason for not using the bio routines?

Just that it's a layering violation.

Could I commend to you the use of code comments for this sort of thing?
