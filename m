Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWG2RNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWG2RNi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWG2RNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:13:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18861 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751405AbWG2RNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:13:37 -0400
Date: Sat, 29 Jul 2006 13:13:18 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: Do backtrace fallback too
Message-ID: <20060729171318.GF16946@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <200607290300.k6T306Fc003168@hera.kernel.org> <200607291835.54379.ak@suse.de> <20060729164238.GB16946@redhat.com> <200607291903.10969.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607291903.10969.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 07:03:10PM +0200, Andi Kleen wrote:
 > 
 > >  > > 	print_symbol("DWARF2 unwinder stuck at %s\n",
 > >  > > 		UNW_PC(info.regs));
 > >  > >
 > >  > > be using %p ?
 > >  >
 > >  > Yes good catch.
 > >
 > > The x86-64 equivalent also has an instance of the same bug.
 > 
 > Actually on double checking the %s is correct because it's print_symbol

Ah, of course. Somehow I missed that on two separate readings of the code.

		Dave

-- 
http://www.codemonkey.org.uk
