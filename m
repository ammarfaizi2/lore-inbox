Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTLKHLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTLKHLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:11:31 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:10634 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264377AbTLKHJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:09:45 -0500
Date: Wed, 10 Dec 2003 23:08:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Ed Sweetman <ed.sweetman@wmich.edu>
cc: Nick Piggin <piggin@cyberone.com.au>, Donald Maner <donjr@maner.org>,
       Raul Miller <moth@magenta.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <1289530000.1071126517@[10.10.2.4]>
In-Reply-To: <20031211054111.GX8039@holomorphy.com>
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--William Lee Irwin III <wli@holomorphy.com> wrote (on Wednesday, December 10, 2003 21:41:11 -0800):

> On Thu, Dec 11, 2003 at 12:33:39AM -0500, Ed Sweetman wrote:
>> I thought highmem wasn't necesarily needed for memory <=2GB? Highmem 
>> incurs some performance hits doesn't it and so the urge to move to it 
>> with only 2GB is not very attractive.  Anyways i'm just interested in if 
>> that's the case or not since 2GB is easy to get to these days and i had 
>> heard that highmem could be avoided passed the 1GB barrier.
> 
> You're probably thinking of 2:2 split patches.
> 
> 2:2 splits are at least technically ABI violations, which is probably
> why this isn't merged etc. Applications sensitive to it are uncommon.
> 
> Yes, the SVR4 i386 ELF/ABI spec literally mandates 0xC0000000 as the
> top of the process address space.

You mean like we place the stack in the "ABI compliant place"? 
Yeah, right ;-)

M.

