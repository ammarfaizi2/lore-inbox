Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262690AbTDARaK>; Tue, 1 Apr 2003 12:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbTDARaK>; Tue, 1 Apr 2003 12:30:10 -0500
Received: from navigator.sw.com.sg ([213.247.162.11]:13447 "EHLO
	navigator.sw.com.sg") by vger.kernel.org with ESMTP
	id <S262690AbTDARaJ>; Tue, 1 Apr 2003 12:30:09 -0500
From: Vladimir Serov <vserov@infratel.com>
To: trond.myklebust@fys.uio.no
Cc: lkml <linux-kernel@vger.kernel.org>
Message-ID: <3E89CF43.2030801@infratel.com>
Date: Tue, 01 Apr 2003 21:41:23 +0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: NFS write got EIO on kernel starting from 2.4.19-pre4 (or -pre3
 maybe)
References: <3E899128.2050200@infratel.com> <16009.49199.898453.578446@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>>>>>>" " == Vladimir Serov <vserov@infratel.com> writes:
>>>>>>            
>>>>>>
>
>     > I'm able to trigger problem by 'dd if=/dev/zero of=test bs=32k
>     > count=1024' I'm using NFS over UDP, and this problem ccured
>     > regardless of soft or hard mounted fs.
>
>You sure about the 'regardless of hard mount' bit? I can write
>multi-gigabyte files with 2.4.21-pre6 without ever seeing an error
>(just now I ran a 3x3GB read/write using iozone without any trouble).
>
>Cheers,
>  Trond
>
Hi,Trond
I know myself that NFS is rather reliable for many yers, I was working 
for many years in HEP community (CERN/ALICE,FNAL/D0,JLAB/CLAS) and used 
NFS all the way processing uncounted terrabytes of data. BUT !!! 
Something in my current setup is triggering some hard to exibit problem. 
Mine previous problem with ARM board for example shows on ten physically 
different boards with several PC different in hardware and software. I 
really don't think it's only hardware problem (but it could be hardware 
related, i mean 3COM NIC's can somehow brighten this problem). Well , I 
don't really know what the hell is going on, That's why I'm calling for 
assistance.

Regards, Vladimir
