Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269921AbUJSRbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269921AbUJSRbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUJSR22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:28:28 -0400
Received: from galaxy.systems.pipex.net ([62.241.162.31]:55007 "EHLO
	galaxy.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267961AbUJSRXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:23:09 -0400
Message-ID: <41754D7B.8090203@dsl.pipex.com>
Date: Tue, 19 Oct 2004 18:23:07 +0100
From: Johan Groth <jgroth@dsl.pipex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ross Biro <ross.biro@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Dma problems with Promise IDE controller
References: <41741CDB.5010300@dsl.pipex.com>	 <58cb370e04101813221d36b793@mail.gmail.com>	 <8783be660410181420683d1341@mail.gmail.com>	 <41753E1D.8010608@dsl.pipex.com> <8783be660410191013230a1b48@mail.gmail.com>
In-Reply-To: <8783be660410191013230a1b48@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro wrote:
[snip]

> 
> The drive still has a bad sector.  You are having trouble because the
> error recover in the Linux ide code is not the same as Windows and
> most drive vendors care about Windows, not the ATA-Spec.  On top of
> that Linux switches out of DMA mode once it hits a bad sector, so the
> drive will be very slow from the on.
> 
> The only way you are going to fix the problem is if your drive has
> some spare sectors still available, and you do a write with out a read
> to the bad sector.

Ok, I pretty sure it has spare sectors. How do I write to that sector 
without a read and how do I find which sector is bad?

Sorry for all these questions but this is the first time I've had these 
kind of problems ever. SCSI disks fix bad blocks by themselves so you 
don't have to do anything.

Regards,
Johan
