Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270371AbRHHHIj>; Wed, 8 Aug 2001 03:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270376AbRHHHI3>; Wed, 8 Aug 2001 03:08:29 -0400
Received: from james.kalifornia.com ([208.179.59.2]:32576 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S270371AbRHHHIP>; Wed, 8 Aug 2001 03:08:15 -0400
Message-ID: <3B70E4C8.2020400@blue-labs.org>
Date: Wed, 08 Aug 2001 03:05:44 -0400
From: David Ford <david@blue-labs.org>
Organization: Blue Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010717
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Ben Ford <ben@kalifornia.com>, David Wagner <daw@mozart.cs.berkeley.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: summary Re: encrypted swap
In-Reply-To: <Pine.LNX.4.33.0108071957170.3450-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can't guarantee much if the machine is physically compromised.  In 
the situation of wiping, you probably won't need swap immediately after 
boot so you can afford to execute a script that wipes the file/partition 
then mounts it.

It's all easily accomplished in userspace.

David

David Lang wrote:

>only if you can guarenty that there is no way to avoid wiping it even if
>this is the 2nd (or 3rd) hard drive (and what about how swap drives that
>get added to a system after boot)
>
>also this had better be a configuration option. I don't want to wait for
>2g of swap space to be wiped when I boot by webserver (which defeates my
>previous requirement)
>
>David Lang
>

