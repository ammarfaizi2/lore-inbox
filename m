Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283286AbRLIKVC>; Sun, 9 Dec 2001 05:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283287AbRLIKUv>; Sun, 9 Dec 2001 05:20:51 -0500
Received: from colorfullife.com ([216.156.138.34]:39693 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S283286AbRLIKUe>;
	Sun, 9 Dec 2001 05:20:34 -0500
Message-ID: <3C133AEA.50605@colorfullife.com>
Date: Sun, 09 Dec 2001 11:20:26 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Carrigan <dave@rudedog.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: Bizarre TCP throughput problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>cbgb-2.4.16	pern	NFS/UDP		~12 MB/s, .5s to copy a 5MB file
> cbgb-2.4.14	pern	HTTP/TCP	 12 MB/s, .5s to copy a 5MB file
> cbgb-2.4.16	pern	HTTP/TCP	7.45 KB/s, 300s to copy a 2MB file
>
Could you try:
- if concurrent flood pings between cbgb an dpern improve the throughput 
with 2.4.16 and HTTP?
 # ping -f pern
or
# ping -f cbdb

- Could you check what happens with 2.4.16 if you revert to the tulip 
driver from 2.4.14?

Copy the entire linux/drivers/net/tulip/ directory from 2.4.16 into 2.4.14.

--
    Manfred

