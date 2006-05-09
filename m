Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWEISOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWEISOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWEISOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:14:15 -0400
Received: from kanga.kvack.org ([66.96.29.28]:59014 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750843AbWEISOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:14:14 -0400
Date: Tue, 9 May 2006 14:14:02 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org, christoph <hch@lst.de>,
       cel@citi.umich.edu
Subject: Re: [PATCH 0/3] VFS changes to collapse AIO and vectored IO  into single (set of) fileops.
Message-ID: <20060509181402.GD2046@kvack.org>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 11:03:45AM -0700, Badari Pulavarty wrote:
> single set of file-operation method using aio_read/aio_write.
> This work was originally suggested & started by Christoph Hellwig,
> when Zach Brown tried to add vectored support for AIO.
> 
> Here is the summary:
> 
> [PATCH 1/3] Vectorize aio_read/aio_write methods
> 
> [PATCH 2/3] Remove readv/writev methods and use aio_read/aio_write
> instead.
> 
> [PATCH 3/3] Zach's core aio changes to support vectored AIO.

They look pretty sane, and I agree they should go into -mm soon.  Cheers,

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
