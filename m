Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTFTQcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTFTQcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:32:54 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:29636 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263311AbTFTQcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:32:47 -0400
Message-ID: <3EF33AD4.6020108@austin.ibm.com>
Date: Fri, 20 Jun 2003 11:48:20 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 umount hangs
References: <3EF1EC73.4070305@austin.ibm.com>	<20030619105817.51613df2.akpm@digeo.com>	<3EF20E86.3030102@austin.ibm.com> <20030619131034.5be8232b.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Steven Pratt <slpratt@austin.ibm.com> wrote:
>  
>
>>Here is the trace of the hung process:
>>
>> umount        D 00000001 290213268 18747  18746                     (NOTLB)
>> Call Trace:
>>  [<c01a1ae8>] journal_kill_thread+0xa8/0xe0
>>    
>>
>
>whoops.  I bet you're seeing this when using some script which does the
>unmount.
>
>Might this help?
>  
>
Yes, this fixed the problem. Thanks.

Steve

