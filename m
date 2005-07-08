Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVGHTUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVGHTUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVGHTSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:18:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3737 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262783AbVGHTRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:17:16 -0400
Message-ID: <42CED123.4010403@sgi.com>
Date: Fri, 08 Jul 2005 15:16:51 -0400
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
CC: Prasanna S Panchamukhi <prasanna@in.ibm.com>, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       systemtap@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [5/6 PATCH] Kprobes : Prevent possible race conditions ia64 changes
References: <20050707101833.GI12106@in.ibm.com> <20050707190645.A29253@unix-os.sc.intel.com> <20050708111045.GA15871@in.ibm.com> <20050708120143.A6837@unix-os.sc.intel.com>
In-Reply-To: <20050708120143.A6837@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S wrote:
> On Fri, Jul 08, 2005 at 04:40:45PM +0530, Prasanna S Panchamukhi wrote:
> 
>>Hi Anil,
>>
>>I have updated the patch as per your comments to move routines
>>from jprobes.S to .kprobes.text section.
>>
>>Please let me know if you any issues.
> 
> Looks fine and tested it too on IA64 Tiger4 box and works as intened.
> Acked-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> 

I ran this on 16p and a 64p ia64 systems and didn't see any issues.

P.

