Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265907AbUFYSov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUFYSov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUFYSov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:44:51 -0400
Received: from chnmfw01.eth.net ([202.9.145.21]:12303 "EHLO ETH.NET")
	by vger.kernel.org with ESMTP id S265907AbUFYSot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:44:49 -0400
Message-ID: <40DC72A2.6080600@eth.net>
Date: Sat, 26 Jun 2004 00:14:50 +0530
From: Amit Gud <gud@eth.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Pavel Machek <pavel@suse.cz>, alan <alan@clueserver.org>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
References: <20040624220318.GE20649@elf.ucw.cz> <Pine.LNX.4.44.0406241544010.19187-100000@www.fnordora.org> <20040625001545.GI20649@elf.ucw.cz> <40DC62BD.3010607@techsource.com>
In-Reply-To: <40DC62BD.3010607@techsource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2004 18:37:06.0734 (UTC) FILETIME=[6AB1F4E0:01C45AE3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

>
> I have a much simpler idea that both implements the EQFS and doesn't 
> touch the kernel.
>
> Each user is given a quota which applies to their home directory.  
> (This quota is not elastic and if everyone met their quota, everything 
> would fit.)  In addition, there is another directory or file system 
> (could be on the same disk or even the same partition) to which their 
> quota doesn't apply AT ALL.  Let's call this "scratch" space.
>
I guess the system should be more transparent to the users and their 
applications. Here its not convenient to generate .o files or caches in 
/scratch/$USER/ .

AG

