Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSJ3EJ5>; Tue, 29 Oct 2002 23:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSJ3EJ5>; Tue, 29 Oct 2002 23:09:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61959 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263794AbSJ3EJ4>;
	Tue, 29 Oct 2002 23:09:56 -0500
Message-ID: <3DBF5CF6.3070103@pobox.com>
Date: Tue, 29 Oct 2002 23:15:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF4DBA.8060005@rackable.com> <3DBF5756.2010702@lougher.demon.co.uk> <3DBF5A08.9090407@pobox.com> <20021029201110.A29661@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>>A r/w compressed filesystem would be darned useful too :)
>>    
>>
>
>mmap(2) is, err, hard.
>
The underlying filesystem format can make things easier on you...  and 
given that compressing inevitably requires some amount of data copying, 
it's not terribly difficult.  I wouldn't claim NTFS is anything close to 
well-designed, but supporting compression under Linux on NTFS is at 
least feasible and shouldn't require tons of thought.  (I've looked at 
it when dicking around with NTFS-TNG)

>  Not impossible, it means the file system has to 
>support both compressed and uncompressed files, but it's interesting.
>  
>
well, yeah... ;-)

    Jeff



