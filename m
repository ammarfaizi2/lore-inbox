Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbTFSUHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbTFSUHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:07:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:65525 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265415AbTFSUHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:07:16 -0400
Message-ID: <3EF21B9C.2040608@austin.ibm.com>
Date: Thu, 19 Jun 2003 15:22:52 -0500
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
>
Yes, I was.  :-)

>Might this help?
>  
>
Will try this tonight.  Should have an answer tomorrow.

Thanks for the quick response.
Steve

