Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946692AbWKAIJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946692AbWKAIJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946693AbWKAIJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:09:38 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:16219 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946692AbWKAIJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:09:38 -0500
Message-ID: <45485541.6060700@openvz.org>
Date: Wed, 01 Nov 2006 11:05:21 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: David Rientjes <rientjes@cs.washington.edu>
CC: Pavel Emelianov <xemul@openvz.org>, balbir@in.ibm.com, vatsa@in.ibm.com,
       dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       menage@google.com, linux-mm@kvack.org
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com> <45470DF4.70405@openvz.org> <45472B68.1050506@in.ibm.com> <4547305A.9070903@openvz.org> <Pine.LNX.4.64N.0610312158240.18766@attu4.cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0610312158240.18766@attu4.cs.washington.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> On Tue, 31 Oct 2006, Pavel Emelianov wrote:
> 
>> Paul Menage won't agree. He believes that interface must come first.
>> I also remind you that the latest beancounter patch provides all the
>> stuff we're discussing. It may move tasks, limit all three resources
>> discussed, reclaim memory and so on. And configfs interface could be
>> attached easily.
>>
> 
> There's really two different interfaces: those to the controller and those 
> to the container.  While the configfs (or simpler fs implementation solely 
> for our purposes) is the most logical because of its inherent hierarchial 
> nature, it seems like the only criticism on that has come from UBC.  From 
> my understanding of beancounter, it could be implemented on top of any 
> such container abstraction anyway.

beancounters may be implemented above any (or nearly any) userspace
interface, no questions. But we're trying to come to agreement here,
so I just say my point of view.

I don't mind having file system based interface, I just believe that
configfs is not so good for it. I've already answered that having
our own filesystem for it sounds better than having configfs.

Maybe we can summarize what we have come to?

> 		David
> 

