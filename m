Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUG2QJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUG2QJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268331AbUG2QFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:05:33 -0400
Received: from services.exanet.com ([212.143.73.102]:38654 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S268253AbUG2QCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:02:55 -0400
Message-ID: <41091FAA.6080409@exanet.com>
Date: Thu, 29 Jul 2004 19:02:50 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmoyer@redhat.com
CC: suparna@in.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       linux-osdl@osdl.org
Subject: Re: [PATCH 20/22] AIO poll
References: <20040702130030.GA4256@in.ibm.com>	<20040702163946.GJ3450@in.ibm.com> <16649.5485.651481.534569@segfault.boston.redhat.com>
In-Reply-To: <16649.5485.651481.534569@segfault.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jul 2004 16:02:51.0863 (UTC) FILETIME=[80683670:01C47585]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Moyer wrote:

>What are the barriers to getting the AIO poll support into the kernel?  I
>think if we have AIO support at all, it makes sense to add this.
>  
>
I second the motion. I don't see how one can write a server which uses 
both networking and block aio without aio poll.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


