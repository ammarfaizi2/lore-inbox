Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262598AbSI0VR6>; Fri, 27 Sep 2002 17:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262599AbSI0VR6>; Fri, 27 Sep 2002 17:17:58 -0400
Received: from host194.steeleye.com ([66.206.164.34]:46088 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262598AbSI0VR5>; Fri, 27 Sep 2002 17:17:57 -0400
Message-Id: <200209272123.g8RLNAi21161@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: mjacob@feral.com
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, Andrew Morton <akpm@digeo.com>,
       Jens Axboe <axboe@suse.de>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
In-Reply-To: Message from Matthew Jacob <mjacob@feral.com> 
   of "Fri, 27 Sep 2002 14:18:12 PDT." <Pine.BSF.4.21.0209271417260.22542-100000@beppo> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Sep 2002 17:23:10 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mjacob@feral.com said:
> Duh. There had been race conditions in the past which caused all of us
> HBA writers to in fact start swalloing things like QFULL and
> maintaining internal queues. 

That was true of 2.2, 2.3 (and I think early 2.4) but it isn't true of late 
2.4 and 2.5

James


