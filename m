Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTEGPfI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbTEGPfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:35:08 -0400
Received: from holomorphy.com ([66.224.33.161]:14224 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263578AbTEGPfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:35:06 -0400
Date: Wed, 7 May 2003 08:47:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Timothy Miller <miller@techsource.com>
Cc: Torsten Landschoff <torsten@debian.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507154728.GG8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Timothy Miller <miller@techsource.com>,
	Torsten Landschoff <torsten@debian.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com> <3EB9250A.8030306@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB9250A.8030306@techsource.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> The kernel stack is (in Linux) unswappable memory that persists
>> throughout the lifetime of a thread. It's basically how many threads
>> you want to be able to cram into a system, and it matters a lot for
>> 32-bit.

On Wed, May 07, 2003 at 11:23:54AM -0400, Timothy Miller wrote:
> The point that may or may not have been obvious is that more than one 
> kernel stack is hanging around.  One single 8k stack versus one single 
> 4k stack is a trivial difference, even for most embedded systems.  But 
> this becomes a huge problem when you have numerous concurrent threads 
> hanging around, one of which can be swapped out.  That eats memory fast.
> Or am I getting it wrong?

You've got it right. Thanks for pointing that out.


-- wli
