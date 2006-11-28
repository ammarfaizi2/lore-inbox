Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935650AbWK1Gjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935650AbWK1Gjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 01:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935661AbWK1Gjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 01:39:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12727 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935650AbWK1Gjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 01:39:40 -0500
Date: Tue, 28 Nov 2006 01:38:19 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jikos@jikos.cz>, Keith Mannthey <kmannth@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: i686 apicid_to_node compile failure.
Message-ID: <20061128063818.GB30889@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jiri Kosina <jikos@jikos.cz>, Keith Mannthey <kmannth@us.ibm.com>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128062746.GA30889@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 01:27:47AM -0500, Dave Jones wrote:
 > arch/i386/mach-generic/built-in.o: In function `apicid_to_node':
 > include/asm/mach-summit/mach_apic.h:90: undefined reference to `apicid_2_node'
 > 
 > config is at http://people.redhat.com/davej/.config

Hmm, odd. It looks like this was fixed a few weeks back in
commit 815a965b0e6d925646e1f6012175830ef21e0d21
but somehow, I still see it broken with rc6-git10.

		Dave

-- 
http://www.codemonkey.org.uk
