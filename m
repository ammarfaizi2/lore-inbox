Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbRCGFrp>; Wed, 7 Mar 2001 00:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRCGFrf>; Wed, 7 Mar 2001 00:47:35 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:36870 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S130214AbRCGFrY>; Wed, 7 Mar 2001 00:47:24 -0500
Message-Id: <200103070546.f275keO22502@aslan.scsiguy.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
cc: LK <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.3 and new aic7xxx 
In-Reply-To: Your message of "Wed, 07 Mar 2001 00:41:39 EST."
             <3AA5CA13.8C19FC7E@neuronet.pitt.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Mar 2001 22:46:40 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've a Super P6SBS motherboard with a builtin dual channel Adaptec 7890
>Ultra II scsi controller. I'm attaching the console grab when booting
>2.4.3-pre2. The controller BIOS is configured to boot off the disk with
>scsi id 0 on channel B.

It looks like Doug was right to think that the functions can be
presented to the device driver in reverse order.  I should have
a patch for you early tomorrow.

--
Justin
