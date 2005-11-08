Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbVKHTJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVKHTJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbVKHTJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:09:18 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:30884 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965255AbVKHTJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:09:17 -0500
Message-ID: <4370F7DA.5000307@us.ibm.com>
Date: Tue, 08 Nov 2005 11:09:14 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>, kernel-janitors@lists.osdl.org,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH 6/8] Cleanup slabinfo_write()
References: <436FF51D.8080509@us.ibm.com> <436FF7F7.1060907@us.ibm.com> <20051108105013.GA7678@mipter.zuzino.mipt.ru> <Pine.LNX.4.62.0511081055430.30907@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511081055430.30907@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 8 Nov 2005, Alexey Dobriyan wrote:
> 
> 
>>On Mon, Nov 07, 2005 at 04:57:27PM -0800, Matthew Dobson wrote:
>>
>>>* Set 'res' at declaration instead of later in the function.
>>
>>I hate to initialize a varible two miles away from the place where it's
>>used.
> 
> 
>  
> 
>>>-	int limit, batchcount, shared, res;
>>>+	int limit, batchcount, shared, res = -EINVAL;
> 
> 
> Looks more confusing than before.

Fair enough.  I'll drop that bit.

-Matt
