Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268130AbUIGRFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbUIGRFE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268223AbUIGRCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 13:02:03 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:5564 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268130AbUIGQ7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:59:23 -0400
Message-ID: <413DE9D3.6050904@sgi.com>
Date: Tue, 07 Sep 2004 12:03:15 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <413D8FB2.1060705@cyberone.com.au>
In-Reply-To: <413D8FB2.1060705@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:
> 
> 
> Just a suggestion - I'd look at the thrashing control patch first.
> I bet that's the cause.
> 
> 
The token based thrashing control patch is also in 2.6.8.1-mm4, and that
kernel doesn't behave nearly as badly as 2.5.9-rc1-mm3, so I don't think
that is the culprit in that case.
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

