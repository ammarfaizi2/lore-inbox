Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbTIKI1h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 04:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTIKI1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 04:27:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51692 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261157AbTIKI1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 04:27:36 -0400
Date: Thu, 11 Sep 2003 10:20:57 +0200
From: Jens Axboe <axboe@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <20030911082057.GP1396@suse.de>
References: <20030910114346.025fdb59.akpm@osdl.org> <10720000.1063224243@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10720000.1063224243@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10 2003, Martin J. Bligh wrote:
> >> I have another oops for you with 2.6.0-test4-mm3-1 and ide-scsi. 
> > 
> > ide-scsi is a dead duck.  defunct.  kaput.  Don't use it.  It's only being
> > kept around for weirdo things like IDE-based tape drives, scanners, etc.
> > 
> > Just use /dev/hdX directly.
> 
> That's a real shame ... it seemed to work fine until recently. Some
> of the DVD writers (eg the one I have - Sony DRU500A or whatever)

Then maybe it would be a really good idea to find out why it doesn't
work with ide-cd. What are the symptoms?

> need it. Is it unfixable? or just nobody's done it?

It's not unfixable, there's just not a lot of motivation to fix it since
it's basically dead.

-- 
Jens Axboe

