Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbSKMRsQ>; Wed, 13 Nov 2002 12:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSKMRsQ>; Wed, 13 Nov 2002 12:48:16 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:62196 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S262020AbSKMRsP>; Wed, 13 Nov 2002 12:48:15 -0500
Message-ID: <3DD29239.2080505@mvista.com>
Date: Wed, 13 Nov 2002 10:56:09 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: Lars Marowsky-Bree <lmb@suse.de>,
       Brian Jackson <brian-kernel-list@mdrx.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
References: <20021113002529.7413.qmail@escalade.vistahp.com> <20021113114641.GI19811@marowsky-bree.de> <3DD28914.3050107@mvista.com> <20021113172530.GF806@nic1-pc.us.oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Waiting to start a failed-over node doesn't work for booting raid 1 
mds...  Since autostart is required.

Joel Becker wrote:

>On Wed, Nov 13, 2002 at 10:17:08AM -0700, Steven Dake wrote:
>  
>
>>Another method is to lock an md array to a specific host.  This method 
>>requires no DLM (since there is no shared write to the same array 
>>capability).
>>    
>>
>
>	But the entire point is to share access.  Otherwise it is pretty
>uninteresting.
>	If you want a failover setup, there is no need for md locking
>either.  Simply have the backup node not start the md until the failover
>happens.
>
>Joel
>
>  
>

