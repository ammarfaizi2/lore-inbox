Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbTIMA6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbTIMA6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:58:24 -0400
Received: from mrout3.yahoo.com ([216.145.54.173]:15377 "EHLO mrout3.yahoo.com")
	by vger.kernel.org with ESMTP id S261979AbTIMA6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:58:22 -0400
Message-ID: <3F626BA9.7040604@bigfoot.com>
Date: Fri, 12 Sep 2003 17:58:17 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: intel D865PERL and DMA for disks (IDE)?
References: <3F62628B.5060805@bigfoot.com> <200309130236.14814.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200309130236.14814.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 13 of September 2003 02:19, Erik Steffl wrote:
... Intel D965PERL and hdparm -d 1 ...
>>CONFIG_BLK_DEV_PIIX=m
>>CONFIG_SCSI_ATA_PIIX=y
> 
> 
> You should use CONFIG_BLK_DEV_PIIX=y
> or load piix module (may not be reliable).

   wow:

jojda:/home/erik# modprobe piix
Segmentation fault

   lsmod | grep piix

piix                    7976   1  (initializing)

   rmmod piix

piix: Device or resource busy

   I guess I'll try to compile it in. thanks,

	erik

