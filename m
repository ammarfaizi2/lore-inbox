Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTDOOKd (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbTDOOKd 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:10:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13988 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261489AbTDOOKc 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 10:10:32 -0400
Date: Tue, 15 Apr 2003 16:22:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <20030415142218.GF814@suse.de>
References: <80690000.1050351598@flay> <200304151401.00704.baldrick@wanadoo.fr> <20030415123134.GM9776@suse.de> <200304151555.36156.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304151555.36156.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15 2003, Duncan Sands wrote:
> > If you do that, you must audit every single BUG_ON to make sure the
> > expression doesn't have any side effects.
> >
> > 	BUG_ON(do_the_good_stuff());
> 
> Good point, but easily dealt with (see other posts).

I'm more inclined to agree with the view that it's a tool chain problem,
if the path leading to the bug isn't considered unlikely.

-- 
Jens Axboe

