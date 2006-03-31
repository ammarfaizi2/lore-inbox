Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWCaSgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWCaSgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWCaSgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:36:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43821 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751058AbWCaSgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:36:13 -0500
Date: Fri, 31 Mar 2006 20:36:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice exports
Message-ID: <20060331183617.GD14022@suse.de>
References: <20060331040613.GA23511@havoc.gtf.org> <1143802879.3053.3.camel@laptopd505.fenrus.org> <20060331110233.GM14022@suse.de> <442D3608.8090906@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442D3608.8090906@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Fri, Mar 31 2006, Arjan van de Ven wrote:
> >>On Thu, 2006-03-30 at 23:06 -0500, Jeff Garzik wrote:
> >>>Woe be unto he who builds their filesystems as modules.
> >>
> >>since splice support is highly linux specific and new.. shouldn't these
> >>be _GPL exports?
> >
> >Yes they should, I'll add that to the current splice tree.
> 
> Why?  We don't usually restrict filesystems in such ways...  I would 
> rather a binary-only module reference generic_file_splice_read() than 
> create its own.

You could use that very same argument for any piece of the kernel, then,
so I don't think that adds much value to _not_ exporting it GPL.

-- 
Jens Axboe

