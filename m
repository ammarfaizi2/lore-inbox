Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWIRX7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWIRX7U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 19:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWIRX7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 19:59:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:40102 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030292AbWIRX7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 19:59:16 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource	beancounters	(v4)	(added	user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       rohitseth@google.com, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <450A71B1.8020009@sw.ru>
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
	 <1158109991.4800.43.camel@linuxchandra>
	 <1158111218.20211.69.camel@galaxy.corp.google.com>
	 <1158186247.18927.11.camel@linuxchandra>  <450A71B1.8020009@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Mon, 18 Sep 2006 16:59:11 -0700
Message-Id: <1158623951.6536.10.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 13:26 +0400, Kirill Korotaev wrote:
> Chandra Seetharaman wrote:
> 
> > esoteric ?! Please look at the different operating system that provide
> > resource management and other resource management capability providers.
> > All of them have both guarantees and limits (they might call them
> > differently).
> > 
> > Here are a few:
> > http://www.hp.com/go/prm
> > http://www.sun.com/software/resourcemgr/
> > http://www.redbooks.ibm.com/redbooks/pdfs/sg245977.pdf
> > http://www.vmware.com/pdf/vmware_drs_wp.pdf
> > http://www.aurema.com
> have you ever tested any of these?!
> there is no _memory_ guarantees AFAIK in all of them except
> for VMware which can reserve required amount of RAM for VM.

I have tried VMware but no others. Nevertheless, I was not talking only
in the context of memory, I was talking about the features
infrastructure should provide (for different resource controllers).
> 
> Kirill
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


