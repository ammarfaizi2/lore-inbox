Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132745AbRDDEjH>; Wed, 4 Apr 2001 00:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132746AbRDDEir>; Wed, 4 Apr 2001 00:38:47 -0400
Received: from f38.law3.hotmail.com ([209.185.241.38]:51729 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S132745AbRDDEim>;
	Wed, 4 Apr 2001 00:38:42 -0400
X-Originating-IP: [65.25.188.54]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2048 byte/sector problems with kernel 2.4
Date: Wed, 04 Apr 2001 04:37:56 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F38vnbEG10Gai4omRXf000005a9@hotmail.com>
X-OriginalArrivalTime: 04 Apr 2001 04:37:56.0949 (UTC) FILETIME=[0544F850:01C0BCC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2001, Harvey Fishman wrote:
>On Tue, 3 Apr 2001, Alan Cox wrote:
>
>> > I also tried it with 2.2.18 there it works but it seems to be >utterly 
>> > slow. I'm using kernel 2.4.2(XFS version to be precise).
>>
>>M/O disks are slow. At a minimum make sure you are using a physical >block 
>>size of 2048 bytes when using 2048 byte media and plenty of memory to 
>> >cache stuff when reading. Seek times on M/O media are pretty poor
>
>Another thing making for the snailicity of MO drives is that writing is >a 
>two pass operation. It is very like core memory; first you write the >spot 
>to a known state, and then you write the data. So you have an average 
>latency of 25 mS. for write operations and 8.33 mS. for read >operations. 
>There WERE direct overwrite media for a while that would, in theory, be 
>able to write the data directly, but a combination of high cost, >limited 
>sources, and strong questions about the permanence of the recorded data 
>severely limited the demand for these and I think that they have been 
>withdrawn.
>
>Harvey

No, direct overwrite disks are expensive, but they are still available. I do 
not know of any, and have not heard of any problems related to direct 
overwrite technology. For some reason M/O never really caught on in the US, 
and the high price of direct overwrite disks is what seems to be killing 
them off. I have a bunch I use for backup and have never had any problems.

Slow is a relative term. Compared to a Seagate X15? Yes, a M/O drive is 
probably slower. Compared to an 8X CD burner? No, my 640MB and 1.3GB M/O 
drives are quite a bit faster, particularly for random writes. For most 
applications, M/O is designed to compete with the latter, rather than the 
former.

People need to remember that M/O drives are meant to compete with CD-R or 
CD-RW as a moderate capacity, highly robust storage medium for archiving and 
backup. But it is somewhat annoying that 2.4.x doesn't (yet) support their 
2K sector sizes correctly.

- John

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

