Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSCRNOu>; Mon, 18 Mar 2002 08:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310783AbSCRNOk>; Mon, 18 Mar 2002 08:14:40 -0500
Received: from [195.63.194.11] ([195.63.194.11]:62225 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310769AbSCRNOb>; Mon, 18 Mar 2002 08:14:31 -0500
Message-ID: <3C95E7E3.4020300@evision-ventures.com>
Date: Mon, 18 Mar 2002 14:13:07 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: =?ISO-8859-1?Q?ChristianBorntr=E4ger?= <christian@borntraeger.net>,
        linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: some ide-scsi commands starve drives on the same cable
In-Reply-To: <E16mIEq-0006nO-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>during some activities (e.g. erasing a CDRW or fixating a CDR on my 
>>CD-Burner) the hard disc on the same cable cannot be accessed.All data and 
>>swap partitions are inaccessable. There is no dmesg output, just entering the
>>mount point fails.
>>I am not sure if it is a kernel problem or if it is a firmware-bug.
> 
> 
> Neither. Its an IDE design limitation. IDE can't handle disconnects like
> real scsi does. The fixate command effectively locks the bus until it
> completes. 
> 
> There has been some movement forward in the standards on this. You might
> want to ask our new 2.5 IDE maintainer if/when it will be implemented - I
> suspect you have to wait a while though. There is much IDE to clean up first

Just for the record: I'm aware of it.

