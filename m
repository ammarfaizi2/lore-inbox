Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWIMBNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWIMBNQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWIMBNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:13:16 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:18322 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030369AbWIMBNP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:13:15 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters
	(v4)	(added	user	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: rohitseth@google.com
Cc: Rik van Riel <riel@redhat.com>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1158108203.20211.52.camel@galaxy.corp.google.com>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <20060912104410.GA28444@in.ibm.com>
	 <1158081752.20211.12.camel@galaxy.corp.google.com>
	 <1158105732.4800.26.camel@linuxchandra>
	 <1158108203.20211.52.camel@galaxy.corp.google.com>
Content-Type: text/plain
Organization: IBM
Date: Tue, 12 Sep 2006 18:13:10 -0700
Message-Id: <1158109991.4800.43.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 17:43 -0700, Rohit Seth wrote:
<snip>

> > It won't be a complete solution, as the user won't be able to
> >  - set both guarantee and limit for a resource group
> >  - use limit on some and guarantee on some
> >  - optimize the usage of available resources 
> 
> I think, if we have some of the dynamic resource limit adjustments
> possible then some of the above functionality could be achieved. And I
> think that could be a good start point.


Yes, dynamic resource adjustments should be available. But, you can't
expect the sysadmin to sit around and keep tweaking the limits so as to
achieve the QoS he wants. (Even if you have an application sitting and
doing it, as I pointed in other email it may not be possible for
different scenarios).
> 
> -rohit
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


