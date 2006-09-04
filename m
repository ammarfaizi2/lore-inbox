Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWIDIJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWIDIJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 04:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWIDIJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 04:09:27 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:63901 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S932491AbWIDIJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 04:09:26 -0400
Date: Mon, 4 Sep 2006 10:09:24 +0200
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: in-kernel rpc.statd
Message-ID: <20060904080924.GA23460@pc51072.physik.uni-regensburg.de>
Reply-To: christian.guggenberger@physik.uni-regensburg.de
References: <20060903180052.GA3743@pc51072.physik.uni-regensburg.de> <Pine.LNX.4.61.0609032255010.6844@yvahk01.tjqt.qr> <1157317915.5587.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157317915.5587.10.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Hm. I do not have a rpc.statd userspace program nor kernel daemon (running 
> > on 2.6.17-vanilla). Yet everything is working. Is there a specific need for 
> > statd?
> 
> Yes. Locking over NFSv2/v3 won't work without it.
> 
> That said, there is no reason why we need an rpc.statd in the kernel
> when the nfs-utils package already provides one that works fine in
> userland.
>

I know. The reason behind my query was just that Suse distros - SLES9 at
least - do not provide userland rpc.statd anymore.

cheers.
 - Christian

-- 
VGER BF report: H 3.23172e-09
