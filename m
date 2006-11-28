Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936057AbWK1T2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936057AbWK1T2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936058AbWK1T2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:28:36 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:32649 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S936057AbWK1T2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:28:35 -0500
Date: Tue, 28 Nov 2006 11:09:01 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Keith Mannthey <kmannth@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       ak@suse.de
Subject: Re: i686 apicid_to_node compile failure.
Message-Id: <20061128110901.de2c380d.randy.dunlap@oracle.com>
In-Reply-To: <20061128190131.GD17111@redhat.com>
References: <20061128062746.GA30889@redhat.com>
	<20061128063818.GB30889@redhat.com>
	<20061128091841.5fde6ffa.randy.dunlap@oracle.com>
	<20061128190131.GD17111@redhat.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 14:01:32 -0500 Dave Jones wrote:

> On Tue, Nov 28, 2006 at 09:18:41AM -0800, Randy Dunlap wrote:
>  > On Tue, 28 Nov 2006 01:38:19 -0500 Dave Jones wrote:
>  > 
>  > > On Tue, Nov 28, 2006 at 01:27:47AM -0500, Dave Jones wrote:
>  > >  > arch/i386/mach-generic/built-in.o: In function `apicid_to_node':
>  > >  > include/asm/mach-summit/mach_apic.h:90: undefined reference to `apicid_2_node'
>  > >  > 
>  > >  > config is at http://people.redhat.com/davej/.config
>  > > 
>  > > Hmm, odd. It looks like this was fixed a few weeks back in
>  > > commit 815a965b0e6d925646e1f6012175830ef21e0d21
>  > > but somehow, I still see it broken with rc6-git10.
>  > 
>  > I reported that one too.  Andi replied that he had a fix for it
>  > in his quilt tree...
> 
> That's worth pushing to 2.6.19 IMO.  Andi ?

Yes, I expected that to be done also.

Linus just mentioned pushing 2.6.19 later today...

---
~Randy
