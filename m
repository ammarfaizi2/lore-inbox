Return-Path: <linux-kernel-owner+w=401wt.eu-S1751300AbXAKBJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbXAKBJ5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbXAKBJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:09:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42841 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbXAKBJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:09:56 -0500
Date: Wed, 10 Jan 2007 17:08:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu,
       Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-Id: <20070110170829.31997fee.akpm@osdl.org>
In-Reply-To: <20070110054419.GA3542@in.ibm.com>
References: <20061227153855.GA25898@in.ibm.com>
	<20061228082308.GA4476@in.ibm.com>
	<20070103141556.82db0e81.akpm@osdl.org>
	<20070104045621.GA8353@in.ibm.com>
	<20070104090242.44dd8165.akpm@osdl.org>
	<20070110054419.GA3542@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007 11:14:19 +0530
Suparna Bhattacharya <suparna@in.ibm.com> wrote:

> On Thu, Jan 04, 2007 at 09:02:42AM -0800, Andrew Morton wrote:
> > On Thu, 4 Jan 2007 10:26:21 +0530
> > Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> > 
> > > On Wed, Jan 03, 2007 at 02:15:56PM -0800, Andrew Morton wrote:
> > 
> > Patches against next -mm would be appreciated, please.  Sorry about that.
> 
> I have updated the patchset against 2620-rc3-mm1, incorporated various
> cleanups suggested during last review. Please let me know if I have missed
> anything:

The s/lock_page_slow/lock_page_blocking/ got lost.  I redid it.

For the record, patches-via-http are very painful.  Please always always
email them.

As a result, these patches ended up with titles which are derived from their
filenames, which are cryptic.
