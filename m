Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSL1Owj>; Sat, 28 Dec 2002 09:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSL1Owj>; Sat, 28 Dec 2002 09:52:39 -0500
Received: from host194.steeleye.com ([66.206.164.34]:22287 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261660AbSL1Owi>; Sat, 28 Dec 2002 09:52:38 -0500
Message-Id: <200212281500.gBSF0pc01929@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Rik van Riel <riel@conectiva.com.br>
cc: Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Janet Morgan <janetmor@us.ibm.com>, "" <linux-scsi@vger.kernel.org>,
       "" <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G 
In-Reply-To: Message from Rik van Riel <riel@conectiva.com.br> 
   of "Sat, 28 Dec 2002 11:33:02 -0200." <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 09:00:51 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

riel@conectiva.com.br said:
> If it's the new driver, it's breaking on WAY too many machines and I
> have no idea why it got ever merged... 

It got merged because no-one was testing it when supplied in its current form 
outside the 2.5 tree and because no-one was fixing the older incarnation of 
this driver that was in the tree.  Including it was a caclulated risk 
mitigated significantly because we still have a maintained aic7xxx_old driver.

So far, the only bug report I have is from Andrew Morton proving that it still 
doesn't get it's bounce buffers right.

I assume all your bug reports are on their way to linux-scsi?

James


