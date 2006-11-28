Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936031AbWK1TJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936031AbWK1TJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936034AbWK1TJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:09:42 -0500
Received: from ns2.suse.de ([195.135.220.15]:25308 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S936031AbWK1TJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:09:41 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: i686 apicid_to_node compile failure.
Date: Tue, 28 Nov 2006 20:09:27 +0100
User-Agent: KMail/1.9.5
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jiri Kosina <jikos@jikos.cz>, Keith Mannthey <kmannth@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
References: <20061128062746.GA30889@redhat.com> <20061128091841.5fde6ffa.randy.dunlap@oracle.com> <20061128190131.GD17111@redhat.com>
In-Reply-To: <20061128190131.GD17111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611282009.27822.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 November 2006 20:01, Dave Jones wrote:
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

Yes, i hope to still get the patches in before .19

-Andi
