Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUF1L65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUF1L65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 07:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUF1L65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 07:58:57 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:12807 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S264913AbUF1L6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 07:58:55 -0400
Message-ID: <40E00935.6040405@hp.com>
Date: Mon, 28 Jun 2004 08:04:05 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Anton Blanchard <anton@samba.org>, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] __alloc_bootmem_node should not panic when it fails
References: <20040627052747.GG23589@krispykreme> <200406270827.28310.ioe-lkml@rameria.de> <20040627222803.GH23589@krispykreme> <20040628062912.GA4391@taniwha.stupidest.org>
In-Reply-To: <20040628062912.GA4391@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Mon, Jun 28, 2004 at 08:28:03AM +1000, Anton Blanchard wrote:
>
>  
>
>>Unfortunately nodes without memory is relatively common on ppc64,
>>and I believe x86-64. From a ppc64 perspective Im fine with best
>>effort, perhaps someone from the heavily NUMA camp (ia64?) could
>>comment.
>>    
>>
>
>Does anyone make ia64 NUMA hardware where you can have memory-less
>nodes?
>
>
>  --cw
>
>  
>
HP ships IA64 NUMA hardware where the default memory configuration is 
memory-less.  There are N-1 cpu-nodes and 1 memory node.

Bob

