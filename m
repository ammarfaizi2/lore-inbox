Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTKEO3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 09:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbTKEO3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 09:29:13 -0500
Received: from ns.suse.de ([195.135.220.2]:32899 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262913AbTKEO3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 09:29:10 -0500
Date: Wed, 5 Nov 2003 13:39:23 +0100
From: Jens Axboe <axboe@suse.de>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031105123923.GP1477@suse.de>
References: <20031105084007.GZ1477@suse.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de> <20031105101207.GI1477@suse.de> <3FA8CEF1.1050200@gmx.de> <20031105102238.GJ1477@suse.de> <3FA8D17D.3060204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA8D17D.3060204@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(cc me, just caught your message by luck)

On Wed, Nov 05 2003, Prakash K. Cheemplavam wrote:
> >>>it's a cdrecord option, I've never used k3b so cannot comment on how to
> >>>make it enable that.
> >>
> >>Hmm, I'll take a look, but I don't really think it is a problem of the 
> >>recording programme, otherwise how could my reader read it out completely?
> >
> >
> >It isn't a problem of the recorder program. But some drives wont read
> >the very end of a disc unless there are some pad blocks at the end.
> >Thus, you should always use the cdrecord pad option.
> 
> Uhm, ok, I just took a look at the source image and the last (missing) 
> 4096 bytes are just 00, so nothing critical missing anyway...so your pad 
> parameter sounds sensible. :) Should drop a note to the k3b devs then, 
> as well...

Good idea, if it's not already an option.

> >Don't remember, sorry :)
> 
> I probably will make a new topic regarding issues (I think) I found with 
> the new mm kernel.

Fine, check the SG_IO thing first though.

-- 
Jens Axboe

