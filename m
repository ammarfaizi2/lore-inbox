Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUG2Rgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUG2Rgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUG2ReK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:34:10 -0400
Received: from services.exanet.com ([212.143.73.102]:31029 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S264299AbUG2RaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:30:14 -0400
Message-ID: <41093421.3080601@exanet.com>
Date: Thu, 29 Jul 2004 20:30:09 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: jmoyer@redhat.com, suparna@in.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, linux-osdl@osdl.org
Subject: Re: [PATCH 20/22] AIO poll
References: <20040702130030.GA4256@in.ibm.com> <20040702163946.GJ3450@in.ibm.com> <16649.5485.651481.534569@segfault.boston.redhat.com> <41091FAA.6080409@exanet.com> <20040729171037.GS2334@holomorphy.com> <410932C2.6080102@exanet.com> <20040729172659.GU2334@holomorphy.com>
In-Reply-To: <20040729172659.GU2334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jul 2004 17:30:10.0519 (UTC) FILETIME=[B2E3AE70:01C47591]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>William Lee Irwin III wrote:
>  
>
>>>I just did it for OLS. The answer is busywait. i.e. 100% cpu. This is
>>>because you can't use timeouts unless they're unified.
>>>      
>>>
>
>On Thu, Jul 29, 2004 at 08:24:18PM +0300, Avi Kivity wrote:
>  
>
>>That's not a server.
>>    
>>
>
>It accepted enough client connections and did enough work on behalf of
>its clients to qualify as such.
>
>Perhaps you have in mind that such a "solution" is inferior (which it is)?
>
>
>  
>
Yes. Sorry for being so terse. But busy-waiting isn't acceptable for 
anything more than a demonstration, or (extermely) special-purpose 
servers, like maybe embedded stuff.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


