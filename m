Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281391AbRKTUn6>; Tue, 20 Nov 2001 15:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281392AbRKTUnt>; Tue, 20 Nov 2001 15:43:49 -0500
Received: from mail.zmailer.org ([194.252.70.162]:46345 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S281371AbRKTUnd>;
	Tue, 20 Nov 2001 15:43:33 -0500
Date: Tue, 20 Nov 2001 22:43:24 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: File size limit exceeded with mkfs
Message-ID: <20011120224324.O2682@mea-ext.zmailer.org>
In-Reply-To: <1006272138.1263.3.camel@somewhere.auc.ca> <20011120113316.R1308@lynx.no> <1006288154.1863.0.camel@somewhere.auc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1006288154.1863.0.camel@somewhere.auc.ca>; from tack@auc.ca on Tue, Nov 20, 2001 at 03:29:14PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 03:29:14PM -0500, Jason Tackaberry wrote:
> Hi Andreas,
> 
> On Tue, 2001-11-20 at 13:33, Andreas Dilger wrote:
... 
> > Can you please try some intermediate kernels (2.4.10 would be a good
> > start, because it had some major changes in this area, and then go
> > forward and back depending whether it works or not).
> 
> 2.4.10 does NOT work.
> 2.4.9 DOES work.

   And noting that  mkfs  and  fsck  operate on block DEVICE, no such
limits should be applied anyway.  Right ?

> So clearly something happened in 2.4.10 which broke this.  Please let me
> know if I can be of any more help.
> 
> Regards,
> Jason.

/Matti Aarnio
