Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUEVTF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUEVTF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 15:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUEVTF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 15:05:26 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:43685 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261787AbUEVTFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 15:05:21 -0400
Message-ID: <40AFA414.7080402@us.ibm.com>
Date: Sat, 22 May 2004 14:03:48 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hch@infradead.org
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
References: <20040522013636.61efef73.akpm@osdl.org> <20040522092627.GA3432@infradead.org> <20040522023218.4d3e34e3.akpm@osdl.org> <20040522094153.GA3672@infradead.org>
In-Reply-To: <20040522094153.GA3672@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch@infradead.org wrote:
> On Sat, May 22, 2004 at 02:32:18AM -0700, Andrew Morton wrote:
> 
>>>code more readable sometimes) or stick a
>>
>>It uses a *ton* of anonymous unions.
>>
>>
>>>#if (__GNUC__ < 3)
>>># error "This driver requires GCC 3.x"
>>>#endif
>>
>>That breaks allfooconfig.
> 
> 
> Well, the patch currently in -mm also breaks allmodconfig.  Just not on
> your arch or with a recent enough compiler, while with this it'll break
> an all arches unless you have a recent enough compiler.  And give the
> driver isn't actually ppc specific that sounds like a really bad tradeoff.

I'll pull out the anonymous unions and submit to linux-scsi.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

