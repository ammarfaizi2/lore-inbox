Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUDRPin (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 11:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUDRPin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 11:38:43 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:64145 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261347AbUDRPik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 11:38:40 -0400
Message-ID: <4082934D.7050507@free.fr>
Date: Sun, 18 Apr 2004 16:40:13 +0200
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Christian_Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Questions : disk partition re-reading
References: <4082819E.10106@free.fr> <200404181707.10467.christian.kroener@tu-harburg.de>
In-Reply-To: <200404181707.10467.christian.kroener@tu-harburg.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kröner wrote:

>On Sunday 18 April 2004 15:24, you wrote:
>  
>
>>Hi,
>>
>>I have 2 questions about disk partitioning under linux 2.6.x :
>>
>>1/ Is it possible to alter a disk partition of a used disk and beeing
>>able to use the modified partition without having to reboot the box?
>>
>>2/ Is it possible to delete a disk partition without having the
>>partition numbers changed?
>>
>>My box is an AMD 2500+/Asus board with FC1 / 2.6.5.
>>
>>Do I need to upgrade fdisk or use an other utility? Or do I need to
>>apply a kernel patch?
>>
>>Regards,
>>Remi
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>All this is possible...
>Use fdisk or cfdisk for editing the partition table and, if youre root 
>partition doesnt reside on the disk, simply use hdparm to let the kernel 
>reread the partition table. You can start formatting the new partitions right 
>after that...
>cheers, christian.
>
>
>  
>
Christian,

I have modified a partition with fdisk.
Then, I have tried to update the in memory partitioning informations, 
but I have the following error message :

# hdparm -z /dev/hdb

/dev/hdb:
BLKRRPART failed : Device or resource busy

An other partition is used on the same disk.

Regards,
Remi



