Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261878AbSIYCN7>; Tue, 24 Sep 2002 22:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261879AbSIYCN7>; Tue, 24 Sep 2002 22:13:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20755 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261878AbSIYCN7>;
	Tue, 24 Sep 2002 22:13:59 -0400
Message-ID: <3D911D00.1080100@pobox.com>
Date: Tue, 24 Sep 2002 22:18:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Christensen <David_Christensen@Phoenix.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Using ATAPI 6 "SET MAX EXT" Command and HDIO_DRIVE_CMD ioctl
References: <E940772158AFE243A3D8D0A741236D4B06CEB1@irv-exch2k.phoenix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Christensen wrote:
> Is there a way to issue the ATAPI 6 "SET MAX EXT" command using the HDIO_DRIVE_CMD ioctl?  As of 2.4.18 kernel, there doesn't seem to be a way to write the high order bytes to the IDE controller to implement the command for a 48bit LBA drive.  Would HDIO_DRIVE_TASKFILE work instead?
> 
> David Christensen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

Take a look at code in drivers/ide/*.c related to CONFIG_IDEDISK_STROKE...

	Jeff



