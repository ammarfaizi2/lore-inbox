Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVKIHiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVKIHiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 02:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVKIHiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 02:38:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44130 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751095AbVKIHiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 02:38:25 -0500
Date: Wed, 9 Nov 2005 08:39:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, htejun@hotmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: + elevator-init-fixes.patch added to -mm tree
Message-ID: <20051109073923.GM3699@suse.de>
References: <200511080351.jA83psjw016612@shell0.pdx.osdl.net> <4370F09C.1050306@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4370F09C.1050306@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08 2005, Zachary Amsden wrote:
> akpm@osdl.org wrote:
> 
> >The patch titled
> >
> >    Elevator init fixes
> >
> >has been added to the -mm tree.  Its filename is
> >
> >    elevator-init-fixes.patch
> > 
> >
> 
> In addition to the first patch, which is probably goodness, I found the 
> cause of my panic - applying this patch fixes it and now I am booting.

I'm guessing you hit the same problem as Marcelo, not configuring the
chosen io scheduler as builtin?

But both patches look fine, I've applied them to the 'for-linus' branch
for 2.6.15. Thanks!

-- 
Jens Axboe

