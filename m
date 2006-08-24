Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422784AbWHXXw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbWHXXw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422785AbWHXXw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:52:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:64674 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422784AbWHXXw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:52:56 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: rohitseth@google.com
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Kirill Korotaev <dev@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156440461.14648.26.camel@galaxy.corp.google.com>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156272902.6479.110.camel@linuxchandra>
	 <1156383881.8324.51.camel@galaxy.corp.google.com>
	 <1156385072.7154.59.camel@linuxchandra>
	 <1156440461.14648.26.camel@galaxy.corp.google.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 24 Aug 2006 16:52:52 -0700
Message-Id: <1156463572.19702.46.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 10:27 -0700, Rohit Seth wrote:

<snip>

> > What do you mean by "resource management part for non-container world
> > already exist ?
> > 
> > It does not. CKRM/Resource Groups is trying to do that, but is not in
> > Linus's tree.
> > 
> 
> Please, non-container is the environment that exist today in Linux.
> Actually cpuset does provide some part of it.  But beyond that no.  

cpuset provides resource _isolation_, not necessarily resource
management.

> 
> But then we are all using different terminology like beancounters,
> containers, resource groups and now non-containers...
> 

<snip>

> > > I'm sure when container support gets in then for the above scenario it
> > > will read -1 ...
> > 
> > So, how can one get the list of tasks belonging to a resource group in
> > that case ?
> > >
> 
> ...and that brings to the starting question...why do you need it?

Like I said earlier, there is _no_ other way to get the list of tasks
belonging to a resource group.

> Commands like ps and top will show appropriate container number for each
> task.

There is _no_ container number in the non-container environment (or it
will be same for _all_ tasks).

> 
> -rohit
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


