Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbTA2TmW>; Wed, 29 Jan 2003 14:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267021AbTA2TmW>; Wed, 29 Jan 2003 14:42:22 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:52231
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S266991AbTA2TmV>; Wed, 29 Jan 2003 14:42:21 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33D71@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Rusty Lynch'" <rusty@linux.co.intel.com>,
       Stanley Wang <stanley.wang@linux.co.intel.com>
Cc: Scott Murray <scottm@somanetworks.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: RE: [Pcihpd-discuss] [RFC] Enhance CPCI Hot Swap driver
Date: Wed, 29 Jan 2003 11:51:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, January 28, 2003 at 12:40 AM, Rusty Lynch wrote:
> 
> On Tue, 2003-01-28 at 23:50, Stanley Wang wrote:
> > Hi, Scott,
> > After reading your CPCI Hot Swap support codes, I have a suggestion
> > to enhance it:
> > How about to make it be full hot swap compliant?
> > I mean we could also do some works like "disable_slot" when 
> we receive
> > the #ENUM & EXT signal. Hence the user could yank the hot 
> swap board 
> > without issuing command on the console.
> > How do you think about it?
> > 
> 
> How does this behavior translate to "full hot swap 
> compliant"?  I assume
> you are talking about wording from PICMG 2.16, which in my opinion
> describes the full software stack, not just the driver.  Any kind of
> full CPCI solution would have all the user space components to
> coordinate disabling a slot before the operator physically yanks the
> board (and therefore behave as PICMG specifies).  I'm not so sure the
> driver knows enough to make a policy decision on what to do when an
> operator bypasses the world and just yanks a board out with 
> no warning.

How is this functionally different from ejecting a PCMCIA card in use? Is
the driver obligated to do more than prevent a system crash and present
errors to user level until the last close? 

Ed
