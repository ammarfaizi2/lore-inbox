Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266617AbUHIPY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266617AbUHIPY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUHIPWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:22:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39630 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266643AbUHIOYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:24:23 -0400
Date: Mon, 9 Aug 2004 16:23:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: alan@lxorguk.ukuu.org.uk, James.Bottomley@steeleye.com, eric@lammerts.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040809142341.GS10418@suse.de>
References: <200408091421.i79ELiPS010580@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091421.i79ELiPS010580@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Joerg Schilling wrote:
> 
> >From: Jens Axboe <axboe@suse.de>
> 
> >On Mon, Aug 09 2004, Alan Cox wrote:
> >> On Llu, 2004-08-09 at 13:24, Joerg Schilling wrote:
> >> > On Linux, it is impossible to run cdrecord without root privilleges.
> >> > Make cdrecord suid root, it has been audited....
> >> 
> >> Wrong. Although in part that is a bug in the kernel urgently needing
> >> a fix.
> 
> >Even with that fixing, write privileges on the device would be enough.
> >So root would still not be required.
> 
> Please try again after you had a look into the cdrtools sources.
> 
> Cdrecord also needs privilleges to lock memory and to raise prioirity.

They are not required, or at least not with the version I use. It warns
of failing to set priority and lock memory, I can continue fine though.
With the casual burning of CDs I do, it's never been a problem.

-- 
Jens Axboe

