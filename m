Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWIVA4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWIVA4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWIVA4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:56:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:23771 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932150AbWIVA4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:56:39 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Menage <menage@google.com>
Cc: npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       rohitseth@google.com, devel@openvz.org, clameter@sgi.com
In-Reply-To: <6599ad830609211713u7356aff7k6400ddcee9651d61@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <20060920173638.370e774a.pj@sgi.com>
	 <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	 <1158803120.6536.139.camel@linuxchandra>
	 <6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
	 <1158869186.6536.205.camel@linuxchandra>
	 <6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
	 <1158875062.6536.210.camel@linuxchandra>
	 <6599ad830609211509x17f0306qbe6d0ef86b86cbc9@mail.google.com>
	 <1158883601.6536.223.camel@linuxchandra>
	 <6599ad830609211713u7356aff7k6400ddcee9651d61@mail.google.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 21 Sep 2006 17:55:36 -0700
Message-Id: <1158886536.6536.230.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 17:13 -0700, Paul Menage wrote:
> On 9/21/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > Think about what will be available to customer through a distro.
> >
> > There are two (competing) memory controllers in the kernel. But, distro
> > can turn only one ON. Which in turn mean
> 
> Why's that? I don't see why cpuset memory nodemasks can't coexist
> with, say, the RG memory controller. They're attempting to solve
> different problems, and I can see situations where you might want to
> use both at once.

Yes, they are two different solutions and I agree that there is no
competition.

Where I see the competition is w.r.t memory controllers from different
resource management solutions (RG, UBC, Rohit's container etc.,). That
is what I was referring to. Sorry for the confusion.

> 
> >
> > So, IMHO, it is better to sort out the differences before we get things
> > in mainline kernel.
> 
> Agreed, if we can come up with a definition of e.g. memory controller
> that everyone agrees is suitable for their needs. You're assuming
> that's so a priori, I'm not yet convinced.
> 
> And I'm not trying to get another memory controller into the kernel,
> I'm just trying to get a standard process aggregation into the kernel
> (or rather, take the one that's already in the kernel and make it
> possible to hook other controller frameworks into it), so that the
> various memory controllers can become less intrusive patches in their
> own right.

I wasn't talking about the competition issue in this context.

Let me clearly state it for the record: I support your effort in
providing an independent process aggregation :)
 
> 
> Paul
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


