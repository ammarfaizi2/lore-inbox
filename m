Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWIOJVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWIOJVr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 05:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWIOJVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 05:21:46 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:20578 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750777AbWIOJVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 05:21:46 -0400
Message-ID: <450A71B1.8020009@sw.ru>
Date: Fri, 15 Sep 2006 13:26:09 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: rohitseth@google.com, Rik van Riel <riel@redhat.com>, vatsa@in.ibm.com,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH] BC: resource	beancounters	(v4)	(added	user
 memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>	 <1157743424.19884.65.camel@linuxchandra>	 <1157751834.1214.112.camel@galaxy.corp.google.com>	 <1157999107.6029.7.camel@linuxchandra>	 <1158001831.12947.16.camel@galaxy.corp.google.com>	 <20060912104410.GA28444@in.ibm.com>	 <1158081752.20211.12.camel@galaxy.corp.google.com>	 <1158105732.4800.26.camel@linuxchandra>	 <1158108203.20211.52.camel@galaxy.corp.google.com>	 <1158109991.4800.43.camel@linuxchandra>	 <1158111218.20211.69.camel@galaxy.corp.google.com> <1158186247.18927.11.camel@linuxchandra>
In-Reply-To: <1158186247.18927.11.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:

> esoteric ?! Please look at the different operating system that provide
> resource management and other resource management capability providers.
> All of them have both guarantees and limits (they might call them
> differently).
> 
> Here are a few:
> http://www.hp.com/go/prm
> http://www.sun.com/software/resourcemgr/
> http://www.redbooks.ibm.com/redbooks/pdfs/sg245977.pdf
> http://www.vmware.com/pdf/vmware_drs_wp.pdf
> http://www.aurema.com
have you ever tested any of these?!
there is no _memory_ guarantees AFAIK in all of them except
for VMware which can reserve required amount of RAM for VM.

Kirill

