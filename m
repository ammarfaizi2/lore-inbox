Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266191AbUFIQJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266191AbUFIQJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266192AbUFIQJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:09:01 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:17804 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266191AbUFIQI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:08:57 -0400
Message-ID: <40C73640.6090400@namesys.com>
Date: Wed, 09 Jun 2004 09:09:36 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jan Kara <jack@suse.cz>, Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Increasing number of inodes after format?
References: <40C62F2F.4090801@techsource.com> <20040609094217.GA14564@atrey.karlin.mff.cuni.cz> <20040609100638.GA18476@infradead.org>
In-Reply-To: <20040609100638.GA18476@infradead.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Wed, Jun 09, 2004 at 11:42:18AM +0200, Jan Kara wrote:
>  
>
>>  ReiserFS also does not have any particular limit on the number of inodes
>>(because it actually does not have any ;).
>>    
>>
>
>they're just called stat_data in reiserfs.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
and there is no limit on them, but there is an objectid limit which is 
32 bits in V3 and 64 bits in V4.
