Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267223AbRGKIG2>; Wed, 11 Jul 2001 04:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbRGKIGU>; Wed, 11 Jul 2001 04:06:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1029 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267223AbRGKIGH>;
	Wed, 11 Jul 2001 04:06:07 -0400
Date: Wed, 11 Jul 2001 10:05:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Eric Youngdale <eric@andante.org>
Cc: Jonathan Lahr <lahr@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711100553.D17314@suse.de>
In-Reply-To: <20010709123936.E6013@us.ibm.com> <20010709214453.U16505@suse.de> <20010710124903.H6013@us.ibm.com> <00a401c1097c$343d45b0$4d0310ac@fairfax.mkssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a401c1097c$343d45b0$4d0310ac@fairfax.mkssoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10 2001, Eric Youngdale wrote:
> 
>     The bit that I had automated was to essentially fix each and every
> low-level SCSI driver such that each low-level driver would be responsible
> for it's own locking.  At this point the patches and the tool are on hold -
> once the 2.5 kernel series gets underway, I can generate some fairly massive
> patchsets.

Cool, sounds good Eric. I'll probably go ahead and complete the initial
ll_rw_blk and IDE work, along with a few selected SCSI drivers. Then
leave the grunt of the work for your tools.

-- 
Jens Axboe

