Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268236AbTBSBXl>; Tue, 18 Feb 2003 20:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268233AbTBSBXl>; Tue, 18 Feb 2003 20:23:41 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:57355 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S268236AbTBSBXk>;
	Tue, 18 Feb 2003 20:23:40 -0500
Date: Wed, 19 Feb 2003 02:21:11 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Simon Kirby <sim@netnation.com>,
       Maciej Rozycki <macro@ds2.pg.gda.pl>
Subject: Re: [Nearly Solved]: APIC routing broken on ASUS P2B-DS
Message-ID: <20030219012111.GB1770@alpha.home.local>
References: <20030128004906.GA3439@netnation.com> <20030128060629.GA19346@alpha.home.local> <20030202012820.GB19346@alpha.home.local> <3E51DC90.6030004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E51DC90.6030004@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 02:11:12AM -0500, Jeff Garzik wrote:
> Willy Tarreau wrote:
> >If I compile my kernel for an SMP K7, only CPU0 gets the interrupts. But if
> >I enable CONFIG_X86_CLUSTERED_APIC by enabling either CONFIG_X86_NUMAQ or
> >CONFIG_X86_SUMMIT (CONFIG_X86_NUMA alone isn't enough), then I get my 
> >interrupts
> >distributed across both CPUs. This is on an Asus A7M266D with 2 Athlon XP 
> >1800+.
> 
> 
> did you ever get a response on this?

Well, Maciej Rozycki replied to me privately saying that he would look at the
problem though he didn't have time right now. I can't blame him, I didn't
either...
 
> The answer is a big fat "don't do that" ;-)
> 
> Summit and Numa are two things your box definitely does not have... 
> don't enable those options.  If you still have problems with those 
> options disabled, please re-post...

If I manage to get a few hours, I might compare the initialization code between
these different modes and try to determine what should be added or removed in
the classical code to make it work. Unfortunately, I'm fairly busy right now,
and trying to understand this unknown area will take some time :-(

Willy

