Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUHCQtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUHCQtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 12:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266715AbUHCQtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 12:49:52 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:39376 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S266725AbUHCQtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 12:49:51 -0400
Message-ID: <410FC22C.8030802@tungstengraphics.com>
Date: Tue, 03 Aug 2004 17:49:48 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Romanick <idr@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com> <410E81C3.2070804@us.ibm.com> <20040802185746.GA12724@redhat.com> <410E9FEE.60108@us.ibm.com> <20040802204553.GC12724@redhat.com> <410ED3F7.7090809@us.ibm.com> <410F443A.7050707@tungstengraphics.com> <410FBD47.2060605@us.ibm.com>
In-Reply-To: <410FBD47.2060605@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Romanick wrote:
> Keith Whitwell wrote:
> 
>> We've actually managed to do a fair bit of cleanup already - if you 
>> look at the gamma driver, there's a lot of stuff in there which used 
>> to be shared but ifdef'ed out between all the drivers.  The 
>> __HAVE_MULTIPLE_DMA_QUEUES macro is a remnant of this, but I think 
>> you'll break gamma when you try & remove it.
> 
> 
> It looks like __HAVE_MULTIPLE_DMA_QUEUES is a superset of 
> __HAVE_DMA_QUEUE.  My thinking was that the code for those two options 
> could be merged.  Does that seem reasonable?

If it looks reasonable in the codebase, I don't know any reason not to.

Keith

