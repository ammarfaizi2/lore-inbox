Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWH1Uft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWH1Uft (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWH1Ufs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:35:48 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:62184 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751483AbWH1Ufs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:35:48 -0400
Message-ID: <44F35537.6000308@student.ltu.se>
Date: Mon, 28 Aug 2006 22:42:31 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 2.6.18-rc4-mm2] fs/jfs: Conversion to generic boolean
References: <44F086E8.7090602@student.ltu.se> <1156774979.7495.5.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1156774979.7495.5.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:

>On Sat, 2006-08-26 at 19:37 +0200, Richard Knutsson wrote:
>  
>
>>From: Richard Knutsson <ricknu-0@student.ltu.se>
>>
>>Conversion of booleans to: generic-boolean.patch (2006-08-23)
>>
>>Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
>>
>>---
>>
>>Compile-tested
>>
>>
>> inode.c        |    2 +-
>> jfs_dmap.c     |   12 ++++++------
>> jfs_extent.c   |   14 +++++++-------
>> jfs_extent.h   |    4 ++--
>> jfs_imap.c     |   26 +++++++++++++-------------
>> jfs_imap.h     |    4 ++--
>> jfs_metapage.h |    4 ++--
>> jfs_txnmgr.c   |   16 ++++++++--------
>> jfs_types.h    |    4 ----
>> jfs_xtree.c    |    2 +-
>> xattr.c        |   10 +++++-----
>> 11 files changed, 47 insertions(+), 51 deletions(-)
>>    
>>
>
>  
>
>>>>original patch removed <<<
>>>>        
>>>>
>
>Richard,
>Here's a version of the patch with completely removes any boolean types
>and constants:
>
>JFS: Conversion of boolean to int
>  
>
<patch removed>

Just why is it, that when there is a change to make locally defined 
booleans into a more generic one, it is converted into integers? ;)
But seriously, what is gained by removing them, other then less 
understandable code? (Not talking about FALSE -> 0, but boolean_t -> int)

I can understand if authors disprove making an integer into a boolean, 
but here it already were booleans.
But hey, you are the maintainer ;)

Richard Knutsson
