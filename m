Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWB1K3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWB1K3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWB1K3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:29:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20309 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932146AbWB1K3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:29:45 -0500
Date: Tue, 28 Feb 2006 11:29:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060228102908.GV24981@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393BFBF@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C270393BFBF@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28 2006, Andy Chittenden wrote:
> > Do the messages go
> > away if you do:
> > 
> > > Looks like a VIA chipset. Disabling IOMMU. Overwrite with
> > > "iommu=allowed"
> > 
> > like that suggests?
> 
> it hangs during boot :-( at:
> 
> hda: cache flushes supported
>  hda:

I guess that definitely doesn't work, then :-)
Let me doctor up a quick debug patch for ide-dma, then.

-- 
Jens Axboe

