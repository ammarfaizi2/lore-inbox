Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267675AbTBRHBi>; Tue, 18 Feb 2003 02:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbTBRHBi>; Tue, 18 Feb 2003 02:01:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34321 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267675AbTBRHBi>;
	Tue, 18 Feb 2003 02:01:38 -0500
Message-ID: <3E51DC90.6030004@pobox.com>
Date: Tue, 18 Feb 2003 02:11:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org, Simon Kirby <sim@netnation.com>
Subject: Re: [Nearly Solved]: APIC routing broken on ASUS P2B-DS
References: <20030128004906.GA3439@netnation.com> <20030128060629.GA19346@alpha.home.local> <20030202012820.GB19346@alpha.home.local>
In-Reply-To: <20030202012820.GB19346@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> If I compile my kernel for an SMP K7, only CPU0 gets the interrupts. But if
> I enable CONFIG_X86_CLUSTERED_APIC by enabling either CONFIG_X86_NUMAQ or
> CONFIG_X86_SUMMIT (CONFIG_X86_NUMA alone isn't enough), then I get my interrupts
> distributed across both CPUs. This is on an Asus A7M266D with 2 Athlon XP 1800+.


did you ever get a response on this?

The answer is a big fat "don't do that" ;-)

Summit and Numa are two things your box definitely does not have... 
don't enable those options.  If you still have problems with those 
options disabled, please re-post...

	Jeff



