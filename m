Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269124AbRHBUXc>; Thu, 2 Aug 2001 16:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269120AbRHBUXW>; Thu, 2 Aug 2001 16:23:22 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:51215 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S269112AbRHBUXN>; Thu, 2 Aug 2001 16:23:13 -0400
Date: Thu, 2 Aug 2001 14:26:31 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Scott Ransom <ransom@cfa.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: 3ware Escalade problems
Message-ID: <20010802142631.A25795@vger.timpanogas.org>
In-Reply-To: <20010801185836.B22548@vger.timpanogas.org> <E15SHUV-0000SM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15SHUV-0000SM-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 02, 2001 at 01:22:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 01:22:15PM +0100, Alan Cox wrote:
> > If you have an adapter, install it, dumop and gendisk head, and take a 
> > look at what's happening.  I am seeing drives being reported with 0 
> > block lengths and other wierdness.    
> 
> Looks fine to me. However if you are seeing 0 block length drives reported
> thats tw_scsiop_read_capacity_complete() causing the sd.c code to do
> something daft.
> 
> Alan

Alan,

Thanks.  I will look at this.  I am running into this problem on 2.2.X 
kernels more so than 2.4.X, but occasionally see it on 2.4.X.  It seems
related to RAID recovery during testing.  We noticed it when we were 
triggering RAID failover for testing.

Jeff

