Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266799AbUHIRxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266799AbUHIRxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUHIRxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:53:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56999 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266799AbUHIRwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:52:08 -0400
Date: Mon, 9 Aug 2004 19:52:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Noah Misch <noah@cs.caltech.edu>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, schilling@fokus.fhg.de
Subject: Re: [PATCH] Make scsi.h nominally userspace-clean
Message-ID: <20040809175200.GA28126@suse.de>
References: <20040809172406.GA1042@orchestra.cs.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809172406.GA1042@orchestra.cs.caltech.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Noah Misch wrote:
> As Joerg Schilling, the author of cdrecord, has noted in threads such as
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/1355.html and
> http://www.ussg.iu.edu/hypermail/linux/kernel/0408.0/0799.html,
> 
> scsi/scsi.h does not compile cleanly in userspace programs due to its
> use of ``u8''.  I have confirmed this bug and prepared and tested a
> fix that simply changes all such uses to ``__u8''.  Please consider
> for inclusion.
> 
> I do not argue that including this header file in a program is
> appropriate, but other kernel headers already take as many precautions
> as this patch introduces.  I chose __u8 over uint8_t as more in the
> style of the kernel generally.
> 
> Please keep me on cc:; I do not subscribe to the lists.

I already sent such a patch to Linus.

-- 
Jens Axboe

