Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUC1SJa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUC1SJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:09:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60108 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262316AbUC1SJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:09:20 -0500
Date: Sun, 28 Mar 2004 20:09:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328180914.GN24370@suse.de>
References: <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328174013.GJ24370@suse.de> <4067101F.9030606@pobox.com> <20040328175559.GM24370@suse.de> <406713A8.6040206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406713A8.6040206@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2004, Jeff Garzik wrote:
> >>I agree completely.  Or, the ATA guys could use SCSI's ordered tags / 
> >>linked commands.
> >>
> >>Regardless, there's ATA dain bramage that needs fixing...  Sigh.
> >
> >
> >Indeed, and it really hurt that they passed up this oportunity last
> >time, ATA TCQ would have kicked so much more ass... Maybe Eric can beat
> >some sense into his colleagues.
> 
> 
> I bet if we can come up with a decent proposal, with technical rationale 
> for the change... that could be presented to the right ATA people :) 
> It's worth a shot.

Count me in for that. The ATA people seem to have a preference for
adding a new set of commands for this type of there, where as I
(originally, I did actually send in a proposal like this on the ml)
wanted to just use one of the reserved bits in the tag field.

-- 
Jens Axboe

