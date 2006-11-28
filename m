Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936030AbWK1TFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936030AbWK1TFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936031AbWK1TFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:05:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18361 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936030AbWK1TF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:05:29 -0500
Date: Tue, 28 Nov 2006 14:01:32 -0500
From: Dave Jones <davej@redhat.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Keith Mannthey <kmannth@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       ak@suse.de
Subject: Re: i686 apicid_to_node compile failure.
Message-ID: <20061128190131.GD17111@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jiri Kosina <jikos@jikos.cz>, Keith Mannthey <kmannth@us.ibm.com>,
	Linus Torvalds <torvalds@osdl.org>, ak@suse.de
References: <20061128062746.GA30889@redhat.com> <20061128063818.GB30889@redhat.com> <20061128091841.5fde6ffa.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128091841.5fde6ffa.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 09:18:41AM -0800, Randy Dunlap wrote:
 > On Tue, 28 Nov 2006 01:38:19 -0500 Dave Jones wrote:
 > 
 > > On Tue, Nov 28, 2006 at 01:27:47AM -0500, Dave Jones wrote:
 > >  > arch/i386/mach-generic/built-in.o: In function `apicid_to_node':
 > >  > include/asm/mach-summit/mach_apic.h:90: undefined reference to `apicid_2_node'
 > >  > 
 > >  > config is at http://people.redhat.com/davej/.config
 > > 
 > > Hmm, odd. It looks like this was fixed a few weeks back in
 > > commit 815a965b0e6d925646e1f6012175830ef21e0d21
 > > but somehow, I still see it broken with rc6-git10.
 > 
 > I reported that one too.  Andi replied that he had a fix for it
 > in his quilt tree...

That's worth pushing to 2.6.19 IMO.  Andi ?

		Dave

-- 
http://www.codemonkey.org.uk
