Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266794AbTA2SMD>; Wed, 29 Jan 2003 13:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbTA2SMD>; Wed, 29 Jan 2003 13:12:03 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:1221 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S266794AbTA2SMB>; Wed, 29 Jan 2003 13:12:01 -0500
Date: Wed, 29 Jan 2003 13:21:19 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Stanley Wang <stanley.wang@linux.co.intel.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] [RFC] Enhance CPCI Hot Swap driver
In-Reply-To: <1043743227.10693.10.camel@vmhack>
Message-ID: <Pine.LNX.4.44.0301291318200.17194-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jan 2003, Rusty Lynch wrote:

> On Tue, 2003-01-28 at 23:50, Stanley Wang wrote:
> > Hi, Scott,
> > After reading your CPCI Hot Swap support codes, I have a suggestion
> > to enhance it:
> > How about to make it be full hot swap compliant?
> > I mean we could also do some works like "disable_slot" when we receive
> > the #ENUM & EXT signal. Hence the user could yank the hot swap board 
> > without issuing command on the console.
> > How do you think about it?
> > 
> 
> How does this behavior translate to "full hot swap compliant"?  I assume
> you are talking about wording from PICMG 2.16, which in my opinion

Slight nitpick, I'm pretty sure you mean PICMG 2.12 here, it's the  
(somewhat lame IMO :) hotswap software spec, 2.16 is the packet switched 
backplane stuff.

> describes the full software stack, not just the driver.  Any kind of
> full CPCI solution would have all the user space components to
> coordinate disabling a slot before the operator physically yanks the
> board (and therefore behave as PICMG specifies).  I'm not so sure the
> driver knows enough to make a policy decision on what to do when an
> operator bypasses the world and just yanks a board out with no warning.

Exactly.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

