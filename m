Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267475AbUG2R3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbUG2R3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUG2R07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:26:59 -0400
Received: from services.exanet.com ([212.143.73.102]:30514 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S264501AbUG2RYU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:24:20 -0400
Message-ID: <410932C2.6080102@exanet.com>
Date: Thu, 29 Jul 2004 20:24:18 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: jmoyer@redhat.com, suparna@in.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, linux-osdl@osdl.org
Subject: Re: [PATCH 20/22] AIO poll
References: <20040702130030.GA4256@in.ibm.com> <20040702163946.GJ3450@in.ibm.com> <16649.5485.651481.534569@segfault.boston.redhat.com> <41091FAA.6080409@exanet.com> <20040729171037.GS2334@holomorphy.com>
In-Reply-To: <20040729171037.GS2334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jul 2004 17:24:19.0222 (UTC) FILETIME=[E1800360:01C47590]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Thu, Jul 29, 2004 at 07:02:50PM +0300, Avi Kivity wrote:
>  
>
>>I second the motion. I don't see how one can write a server which uses 
>>both networking and block aio without aio poll.
>>    
>>
>
>I just did it for OLS. The answer is busywait. i.e. 100% cpu. This is
>because you can't use timeouts unless they're unified.
>
>
>  
>
That's not a server.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


