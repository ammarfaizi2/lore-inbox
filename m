Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWAFObk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWAFObk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 09:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWAFObj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 09:31:39 -0500
Received: from mexforward.lss.emc.com ([168.159.213.200]:26788 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750771AbWAFObj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 09:31:39 -0500
Message-ID: <43BE7EE4.3010203@emc.com>
Date: Fri, 06 Jan 2006 09:29:56 -0500
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: akpm@osdl.org, schwidefsky@de.ibm.com, arnd@arndb.de,
       linux-kernel@vger.kernel.org,
       "saparnis, carol" <saparnis_carol@emc.com>
Subject: Re: [PATCH 2/2] dasd: remove dynamic ioctl registration
References: <20051216143348.GB19541@lst.de> <20060106110157.GA16725@lst.de> <43BE7C45.4090206@emc.com> <20060106142146.GA20094@lst.de>
In-Reply-To: <20060106142146.GA20094@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2006.1.6.11
X-PerlMx-Spam: Gauge=, SPAM=0%, Reasons='EMC_BODY_1+ -5, EMC_BODY_PROD_1+ -4, EMC_FROM_00+ -3, __C230066_P3_4 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christoph Hellwig wrote:

>>If you could hold off just a couple of weeks, I hope that we can get 
>>through our EMC process junk and get the GPL'ed patch out to fix the 
>>symmetrix support part of this rolled in as well,
>>    
>>
>
>Why?  We never do things to support legally questionable binary modules.
>And on the practical side, does emc even ship modules for -mm release?
>What's the point of not putting it into -mm?
>  
>
No need for an EMC module, I think that we can issue a simple  patch to 
dasd.c that removes the (silly) binary module that was there.

I would prefer that the clean up not break one of the few (and 
relatively common) devices supported by the dasd.c driver. If for no 
other reason, it would seem to make it more likely to be able test the 
existing patch properly.

ric

