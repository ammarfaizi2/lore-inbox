Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVD0Rqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVD0Rqw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVD0RpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:45:20 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:23982 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261888AbVD0Roo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:44:44 -0400
Message-ID: <426FCF7B.5020806@nortel.com>
Date: Wed, 27 Apr 2005 11:44:27 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>, linux-kernel@vger.kernel.org
Subject: Re: any way to find out kernel memory usage?
References: <426FBFED.9090409@nortel.com> <426FC0FE.2090900@oktetlabs.ru>	 <426FC46C.4070306@nortel.com> <1114622438.10836.8.camel@betsy>
In-Reply-To: <1114622438.10836.8.camel@betsy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Wed, 2005-04-27 at 10:57 -0600, Chris Friesen wrote:
> 
> 
>>I assume kmalloc/vmalloc use the "size-x" slabs?
> 
> 
> kmalloc, yes.
> 
> vmalloc is separate, totally unrelated, space.
> 
> Statistics are in /proc/meminfo.

Okay, so can I get the total amount of memory used by the kernel based 
on meminfo output?  (Slab + VmallocUsed) maybe?

Chris



