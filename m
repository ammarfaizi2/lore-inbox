Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269283AbTCBTph>; Sun, 2 Mar 2003 14:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269284AbTCBTph>; Sun, 2 Mar 2003 14:45:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25356 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269283AbTCBTpg>;
	Sun, 2 Mar 2003 14:45:36 -0500
Message-ID: <3E6261C3.1020700@pobox.com>
Date: Sun, 02 Mar 2003 14:55:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Buesch <freesoftwaredeveloper@web.de>
CC: Hanasaki JiJi <hanasaki@hanaden.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.20 ide-scsi
References: <3E625282.8010101@hanaden.com> <200303022038.53606.freesoftwaredeveloper@web.de>
In-Reply-To: <200303022038.53606.freesoftwaredeveloper@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
>>CONFIG_BLK_DEV_IDECD=y
> 
> 
> seems, that you have made the same mistake like me yesterday.
> (Thanks to Brian Davis again)
> 
> Just disable CONFIG_BLK_DEV_IDECD and try if it works.


The standard solution, supported by all major distributions, is to supply
	hdX=ide-scsi
on the kernel command line.

There is no need to completely disable IDE-CD.  IDE-CD and IDE-SCSI can 
and do interoperate all the time.

	Jeff



