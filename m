Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268257AbUIPVBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbUIPVBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUIPVBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:01:42 -0400
Received: from advect.atmos.washington.edu ([128.95.89.50]:22674 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S268257AbUIPVBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:01:22 -0400
Message-ID: <4149FF1D.7090302@atmos.washington.edu>
Date: Thu, 16 Sep 2004 14:01:17 -0700
From: Harry Edmon <harry@atmos.washington.edu>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: page allocation or what in 2.6.8.1
References: <20040831120232.18dfa3c0.akpm@osdl.org>	<200408312221.i7VMLHPu007234@moist.atmos.washington.edu> <20040831154713.470e25a6.akpm@osdl.org>
In-Reply-To: <20040831154713.470e25a6.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -14.434 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once I mounted "nfsd" and went to autofs4 all problems went away with 
2.6.9-rc1-bk9.  Thanks for the help.

Andrew Morton wrote:

>Harry Edmon <harry@atmos.washington.edu> wrote:
>  
>
>>So far, no crash.  But now I have NFS clients that from time to time are unable
>>to access this server.  The server has the following messages on it:
>>
>>Aug 31 15:16:43 funnel rpc.mountd: getfh failed: Operation not permitted
>>
>>I can temporarily fix the problem by typing:
>>
>>exportfs -ar
>>
>>But eventually it happens again.
>>
>>    
>>
>
>Well there were a few other NFS fixes.  Can you test the latest kernel
>from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/ ?
>  
>

