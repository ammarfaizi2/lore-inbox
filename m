Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265600AbUABOiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 09:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUABOiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 09:38:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22158 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265600AbUABOiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 09:38:19 -0500
Date: Fri, 2 Jan 2004 15:38:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GetASF failed on DVD authentication
Message-ID: <20040102143804.GR5523@suse.de>
References: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com> <20040102103949.GL5523@suse.de> <Pine.LNX.4.58.0401022219290.10338@silk.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401022219290.10338@silk.corp.fedex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02 2004, Jeff Chua wrote:
> 
> On Fri, 2 Jan 2004, Jens Axboe wrote:
> 
> > > GetASF failed
> > > N/A, invalidating: Function not implemented
> > > N/A, invalidating: Function not implemented
> > > N/A, invalidating: Function not implemented
> > > Request AGID [1]...     Request AGID [2]...     Request AGID [3]...
> > > Cannot get AGID
> 
> 
> > > This error happens only on USB DVD drive using /dev/scd0 ...
> 
> USB drive is a Pioneer DVR-SK11B-J. It's reported as ...
> 
> scsi0 : SCSI emulation for USB Mass Storage devices
>   Vendor: PIONEER   Model: DVD-RW  DVR-K11   Rev: 1.00
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> 
> I've tried at least 2 other USB drives (Plextor PX-208U, and Sony CRX85U),
> and both of these drives also exhibit the same problem.
> 
> 
> > > Linux version is 2.4.24-pre3.
> 
> 
> > I can't say what goes wrong from the info above. Do you get any kernel
> > messages?
> 
> No kernels oops. Just those "GetASF failed" messages above.

I forget which, but there's an option to make usb-storage dump all
commands going through it. If you could enable that and send the
results, that would help a lot.


-- 
Jens Axboe

