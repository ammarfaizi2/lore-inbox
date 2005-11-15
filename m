Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVKOHuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVKOHuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 02:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVKOHuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 02:50:35 -0500
Received: from styx.suse.cz ([82.119.242.94]:49324 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751363AbVKOHuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 02:50:35 -0500
Date: Tue, 15 Nov 2005 08:50:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, george@mvista.com, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
Message-ID: <20051115075026.GA11994@midnight.suse.cz>
References: <43720DAE.76F0.0078.0@novell.com> <20051112204428.GA14733@midnight.suse.cz> <43792DFF.1000300@mvista.com> <200511150205.25339.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511150205.25339.ak@suse.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 02:05:24AM +0100, Andi Kleen wrote:

> On Tuesday 15 November 2005 01:38, George Anzinger wrote:
> 
> > Doesn't this depend on the atomic nature of the 64-bit read?  If it
> > is really two 32-bit reads one would need to do extra work to make
> > sure the two parts belong together.
> 
> Please take a look at the Subject.
 
Still, the HPET doesn't necessarily have to be a 64-bit device. At least
on AMD systems, where it's implemented in AMD8111 Thor, it's bundled
together with other, 32-bit PCI devices like USB. On the other hand, the
8111 HPET doesn't implement a 64-bit conter, and it's likely that the
Intel implementation in the northbridges (or *CH, as Intel prefers
calling the things) is likely native 64-bit.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
