Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbTANIh7>; Tue, 14 Jan 2003 03:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbTANIh7>; Tue, 14 Jan 2003 03:37:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:2538 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261723AbTANIh6> convert rfc822-to-8bit;
	Tue, 14 Jan 2003 03:37:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: fcorneli@elis.rug.ac.be, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace, kernel 2.5.56
Date: Tue, 14 Jan 2003 00:47:25 -0800
User-Agent: KMail/1.4.3
Cc: Frank.Cornelis@elis.rug.ac.be
References: <Pine.LNX.4.44.0301140917240.11512-100000@tom.elis.rug.ac.be>
In-Reply-To: <Pine.LNX.4.44.0301140917240.11512-100000@tom.elis.rug.ac.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301140047.25074.akpm@digeo.com>
X-OriginalArrivalTime: 14 Jan 2003 08:46:43.0670 (UTC) FILETIME=[76CB5760:01C2BBA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue January 14 2003 00:25, fcorneli@elis.rug.ac.be wrote:
>
> Hi,
> 
> According to Documentation/cachetlb.txt flush_dcache_page should also be 
> called when the kernel _is about_ to read from a page and user space 
> shared&writable mappings of this page potentially exist. I think 
> kernel/ptrace.c should be fixed on this issue.
> I already posted this patch on the lkml a few months ago, but it got lost 
> I guess.
> Where should I send ptrace patches to in the future? Anyone out there who 
> maintains the ptrace stuff?
> 

Actually, I've had this patch in the -mm patches since you sent it.  But Dave
Miller says it's not quite right, and that we need additional infrastructure
to correctly solve the problem which you have identified.

So I've kept your patch in place as a reminder to bug Dave ;)


