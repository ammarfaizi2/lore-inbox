Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUDWVPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUDWVPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUDWVPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:15:47 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:48391 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261443AbUDWVPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:15:45 -0400
Message-ID: <40898834.7040803@techsource.com>
Date: Fri, 23 Apr 2004 17:18:44 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se> <Pine.LNX.4.53.0404231651120.1643@chaos>
In-Reply-To: <Pine.LNX.4.53.0404231651120.1643@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:

> 
> Actually not. You need a FIFO to cache your bits into buffers of bytes
> anyway. Depending upon the length of the FIFO, you can "rubber-band" a
> lot of rotational latency. When you are dealing with a lot of drives,
> you are never going to have all the write currents turn on at the same
> time anyway because they are (very) soft-sectored, i.e., block
> replacement, etc.
> 
> Your argument was used to shout down the idea. Actually, I think
> it was lost in the NIH syndrome anyway.
> 


In a drive with multiple platters and therefore multiple heads, you 
could read/write from all heads simultaneously.  Or is that how they 
already do it?


