Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTK3S12 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 13:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbTK3S12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 13:27:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64692 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263007AbTK3S10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 13:27:26 -0500
Message-ID: <3FCA367B.3070308@pobox.com>
Date: Sun, 30 Nov 2003 13:27:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Craig Bradney <cbradney@zip.com.au>
CC: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>,
       linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FCA2E49.9040707@wanadoo.es> <1070212432.28187.25.camel@athlonxp.bradney.info>
In-Reply-To: <1070212432.28187.25.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:
> On the topic of speeds.. hdparm -t gives me 56Mb/s on my Maxtor 80Mb 8mb
> cache PATA drive. I got that with 2.4.23 pre 8 which was ATA100 and get
> just a little more on ATA133 with 2.6. Not sure what people are
> expecting on SATA.


Serial ATA merely changes the bus, a.k.a. the interface between drive 
and system.

This doesn't mean that the drive itself will be any faster...  most 
first-gen SATA drives are just PATA drives with a new circuit board and 
new firmware.  Just like some SCSI and IDE drives are exactly the same 
platters, but have differing circuit boards and connectors...

	Jeff



