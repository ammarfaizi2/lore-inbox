Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbTH2R2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbTH2R2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:28:15 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:51087 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261331AbTH2R2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:28:07 -0400
Message-ID: <3F4F8BA7.1080002@rackable.com>
Date: Fri, 29 Aug 2003 10:21:43 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: libata update posted (was Re: VIA Serial ATA chipset)
References: <20030813074535.C3AB427AC8@mail.medav.de> <3F4F6863.4080400@pobox.com>
In-Reply-To: <3F4F6863.4080400@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Aug 2003 17:28:06.0137 (UTC) FILETIME=[E85E3E90:01C36E52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>
> So, here are the 2.4 and 2.6 versions of the VIA SATA support for 
> libata, contained in the latest libata update.
>
> 2.4 BK: bk://kernel.bkbits.net/jgarzik/atascsi-2.4
> 2.4 Patch: 
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.23-pre1-libata3.patch.bz2 
>
>
> 2.6 BK: bk://kernel.bkbits.net/jgarzik/atascsi-2.6
> 2.6 Patch: 
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test4-bk2-libata3.patch.bz2 
>
>
>
> Changes:
> * add VIA SATA driver
> * fixes to software reset.
> * other fixes
> * split scsi-related code into separate file, libata-scsi.c.
> * continue work on phy layer
> * continue work towards fully async taskfile API:  you call 
> submit_tf(), and later on, your callback is called when the taskfile 
> completes or times out.   async taskfile API is required for ATAPI and 
> supporting more advanced host controllers like Promise or AHCI (SATA2).
> * some cleanups
>
>  
>

   I'm guessing there is no support for Promise yet? 

  I'm just asking because I've got this dual amd64 with 4 Promise sata 
ports.  Which for some reason there aren't drivers any 64 bit OS;-(


PS-  The driver works great on the silcon image chipset.  (Once I 
realized that my Seagate drive needed newer firmware.)

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


