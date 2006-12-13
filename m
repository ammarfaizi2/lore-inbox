Return-Path: <linux-kernel-owner+w=401wt.eu-S932602AbWLMHTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWLMHTg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 02:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWLMHTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 02:19:36 -0500
Received: from brick.kernel.dk ([62.242.22.158]:27476 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932602AbWLMHTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 02:19:35 -0500
X-Greylist: delayed 1688 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 02:19:35 EST
Date: Wed, 13 Dec 2006 07:52:46 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "AVANTIKA R. MATHUR" <mathur@linux.vnet.ibm.com>
Cc: Avantika Mathur <mathur@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: cfq performance gap
Message-ID: <20061213065244.GJ4576@kernel.dk>
References: <1165536200.25180.1.camel@dyn9047017105.beaverton.ibm.com> <20061208120522.GN23887@kernel.dk> <1165615793.9200.11.camel@dyn9047017105.beaverton.ibm.com> <20061211140845.GL4576@kernel.dk> <457F583B.9090109@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457F583B.9090109@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12 2006, AVANTIKA R. MATHUR wrote:
> >That said, I might add some logic to detect when we can cheaply switch
> >queues instead of waiting for a new request from the same queue.
> >Averaging slice times over a period of time instead of 1:1 with that
> >logic, should help cases like this while still being fair.
> >  
> Thank you for looking at this issue.
> I've found an IBM/SUSE bugzilla bug for the same performance gap on 
> rawio. There was a fix for this bug included in SLES10-RC1, do you know 
> why it was not added in mainline?

Which bug do you mean? It was likely me doing the fixing on that bug,
and I'm certain that the patch is in mainline. If you included the bug
number, I could have expanded on that.

-- 
Jens Axboe

