Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWISIEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWISIEy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 04:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWISIEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 04:04:54 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:62254 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751308AbWISIEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 04:04:52 -0400
Message-ID: <450FA4A2.4050801@openvz.org>
Date: Tue, 19 Sep 2006 12:04:50 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: balbir@in.ibm.com, Rik van Riel <riel@redhat.com>,
       Srivatsa <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>	 <44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>	 <1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>	 <1157730221.26324.52.camel@localhost.localdomain>	 <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>	 <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>	 <1158000590.6029.33.camel@linuxchandra>	<45069072.4010007@openvz.org>	 <1158105488.4800.23.camel@linuxchandra>	<4507BC11.6080203@openvz.org>	 <1158186664.18927.17.camel@linuxchandra>	<45090A6E.1040206@openvz.org>	 <1158277364.6357.33.camel@linuxchandra>	<450A5325.6090803@openvz.org>	 <450A6A7A.8010102@sw.ru> <450A8B61.7040905@openvz.org>	 <450E5813.2040804@in.ibm.com>  <450E5F2E.2070809@openvz.org> <1158624359.6536.17.camel@linuxchandra>
In-Reply-To: <1158624359.6536.17.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Mon, 2006-09-18 at 12:56 +0400, Pavel Emelianov wrote:
>
> <snip>
>
>   
>> The same for the limiting - either do not start new container, or
>> recalculate limits to meet new requirements. You may not take care of
>> guarantees as weel and create an overcommited configuration.
>>
>> And one more thing. We've asked it many times and I ask it again -
>> please, show us the other way for providing guarantee rather than
>> limiting or reserving.
>>     
>
> Why do we want the capability to be snipped at the infrastructure level.
> Let the controller writers decide how they want to provide the
> capability and the users to decide if they want to use the feature at a
> price.
>   

That's what we proposed in the very beginning - to review an infrastructure
with minimal functionality (limiting) and develop new features after the
"core"
is accepted.

I'm glad that we've finaly made a bargain :)

>   
>> -------------------------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services, security?
>> Get stuff done quickly with pre-integrated technology to make your job easier
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>> _______________________________________________
>> ckrm-tech mailing list
>> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
>>     

