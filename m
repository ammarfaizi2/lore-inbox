Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271132AbTGPVPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271076AbTGPVPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:15:17 -0400
Received: from eq16.auctionwatch.com ([66.7.130.111]:46127 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id S271133AbTGPVPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:15:07 -0400
Date: Wed, 16 Jul 2003 14:29:44 -0700
From: Petro <petro@corp.vendio.com>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20030716212944.GB30218@corp.vendio.com>
References: <20030715223342.GH26404@corp.vendio.com> <E19catr-0002rI-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19catr-0002rI-00@calista.inka.de>
User-Agent: Mutt/1.5.4i
Subject: Re: LVM, snapshots and Linux 2.4.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 03:16:07AM +0200, Bernd Eckenfels wrote:
> In article <20030715223342.GH26404@corp.vendio.com> you wrote:
> > if I turn off HIGHIO, the lvcreate command completes successfully, but
> > the snapshot is unmountable. 
> 
> kvm was segfaulting for me with xfs if the snapsht volume gets full, but I
> think this is fixed.
> What filesystem do you had on the snapshot volume? Depending on the
> filesystem, you may need to mount it without journal replay, or with
> ignoring duplicate uuids.

    Kernel 2.4.18 segfaults when I do the lvcreate -s 
    
    Kernel 2.4.21 with the HighMem I/O fails on the lvcreate -s. 
    
    Kernel 2.4.21 without HighMem I/O fails but with High mem fails 
                  when I try to mount the snapshot. 

    Kernel 2.4.21 without high memory, and without high i/o suceeds 
                  in both creating and mounting the snapshot. 

-- 
"On two occasions, I have been asked [by members of Parliament], 'Pray, 
Mr. Babbage, if you put into the machine wrong figures, will the right 
answers come out?' I am not able to rightly apprehend the kind of confusion 
of ideas that could provoke such a question." -- Charles Babbage 
