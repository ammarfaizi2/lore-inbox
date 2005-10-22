Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbVJVRv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVJVRv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVJVRv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:51:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8928 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750855AbVJVRv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:51:58 -0400
Date: Sat, 22 Oct 2005 18:51:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: David Lang <david.lang@digitalinsight.com>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attachedPHYs)
Message-ID: <20051022175155.GA8079@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	David Lang <david.lang@digitalinsight.com>,
	linux-scsi@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
	Christoph Hellwig <hch@lst.de>,
	"Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
	Linus Torvalds <torvalds@osdl.org>
References: <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com> <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de> <Pine.LNX.4.62.0510220357250.4997@qynat.qvtvafvgr.pbz> <435A79B4.9070201@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435A79B4.9070201@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2005 at 07:41:08PM +0200, Stefan Richter wrote:
> What I was referring to was to clean up a _part_ of the subsystem (the 
> core), not to replace the subsystem. I admit though that my wording left 
> much room for misunderstanding.
> 
> Furthermore, note that the "scsi-cleanup tree" which I referred to is 
> not meant to be a fork. It should merely be another working stage before 
> the -mm stage. And let me add that this stage should be left as soon as 
> possible.

gosh, could you please shut up and code now?

There's been various TODO items posted:

 (1) my TODO list for making the core HCIL idependent
 (2) finishing the transition to remove struct scsi_request and only
     send down S/G list
 (3) get rid of legacy host probing

and we'd all be happy if you added to the list.  Talking doesn't change
anything, please submit patches and help moving things forward.  Thanks.

And please start a new thread for such suggestions, this thread has finally
managed to get into my killfile.

