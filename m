Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266596AbUHIORL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266596AbUHIORL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUHIOJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:09:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12488 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266595AbUHIOID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:08:03 -0400
Date: Mon, 9 Aug 2004 16:07:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, eric@lammerts.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040809140733.GM10418@suse.de>
References: <200408091224.i79COp69009736@burner.fokus.fraunhofer.de> <1092056464.14152.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092056464.14152.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Alan Cox wrote:
> On Llu, 2004-08-09 at 13:24, Joerg Schilling wrote:
> > On Linux, it is impossible to run cdrecord without root privilleges.
> > Make cdrecord suid root, it has been audited....
> 
> Wrong. Although in part that is a bug in the kernel urgently needing
> a fix.

Even with that fixing, write privileges on the device would be enough.
So root would still not be required.

-- 
Jens Axboe

