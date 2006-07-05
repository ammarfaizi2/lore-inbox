Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWGERs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWGERs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWGERs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:48:28 -0400
Received: from web33508.mail.mud.yahoo.com ([68.142.206.157]:3933 "HELO
	web33508.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964925AbWGERs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:48:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OAQdmWmWC/eFd9Ii9unDYLpeA+9x6D/nqpi0J4+NSDbDbZXGSs8WrAuokADw/SqLL/hA3ouN/RrTfBTu6pMd5OtYvGIIs3Xc3Kx6R82ejYDGC23sMowp+7I1p45mUxvwrsVBfx4vH9QkyfAjfhC3yxgJW/XzeQVLfiWpc24PYyI=  ;
Message-ID: <20060705174826.60724.qmail@web33508.mail.mud.yahoo.com>
Date: Wed, 5 Jul 2006 10:48:26 -0700 (PDT)
From: Narendra Hadke <nhadke@yahoo.com>
Subject: Re: Fwd: Re: sata_mv driver on 88sx6041 ( 2.6.14): PCI IRQ error
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44ABF7DF.5050607@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, 
 Really apreciate your help on this.
   How this works for PIO mode? SATA Disk looks 
 perfectly visible in PIO mode. The problem is when I
 go to DMA mode.
  Is this problem specific to DMA mode?
Thanks,
Narendra

--- Jeff Garzik <jeff@garzik.org> wrote:

> Narendra Hadke wrote:
> > Hi,
> >     The sata_mv I am using is with
> >   "three fixes" ie 0.6 on kernel version 2.6.14
> > (Marvell 6041 part) without the IEN related
> change. 
> > libata & scsi are modified(imported change from
> later
> > version of kernel) to make this change 
> > compile.(With IEN change  driver gets truck after 
> > identifying the disk)
> >    I  got rid of the disk errors but the next the
> >  error I am getting is related to PCI IRQ.
> > -----------------------------------------
> > SCSI device sda: drive cache: write back
> >  sda:<3>sata_mv: PCI ERROR; PCI IRQ
> cause=0x00000400
> 
> "PCI ERROR" is the hardware signalling that a major
> PCI-bus-related 
> error has occurred.
> 
> Try moving the controller to a new PCI slot, or
> other hardware-level fixes.
> 
> 	Jeff
> 
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
