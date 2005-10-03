Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVJCCaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVJCCaa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 22:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVJCCaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 22:30:30 -0400
Received: from dvhart.com ([64.146.134.43]:30098 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750982AbVJCCa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 22:30:29 -0400
Date: Sun, 02 Oct 2005 19:30:34 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: jonathan@jonmasters.org, Marc Singer <elf@buici.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Discontiguous memory fun
Message-ID: <58910000.1128306634@[10.10.2.4]>
In-Reply-To: <35fb2e590510021910t49980f4t9bd29201dc90be05@mail.gmail.com>
References: <35fb2e5905090110171aa77266@mail.gmail.com> <35fb2e590510021157l63f6a270l2810659427a8fa9e@mail.gmail.com> <20051002235512.GA15138@buici.com> <35fb2e590510021910t49980f4t9bd29201dc90be05@mail.gmail.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Jon Masters <jonmasters@gmail.com> wrote (on Monday, October 03, 2005 03:10:28 +0100):

> On 10/3/05, Marc Singer <elf@buici.com> wrote:
> 
>> On Sun, Oct 02, 2005 at 07:57:30PM +0100, Jon Masters wrote:
>> > Replying to my own post...
>> > 
>> > On 9/1/05, Jon Masters <jonmasters@gmail.com> wrote:
>> > 
>> > I'd love to know what the state of discontig memory is like on 2.6
>> > series ARM kernels and highmem too for that matter, but I've not had
>> > chance to look at it (I'm usually a ppc guy).
>> 
>> It works fine.
>> 
>> The node mapping is performed by macros in asm-arm/arch-*/memory.h.
> 
> Hmmm...as it was in 2.4. I'll take a look for my general interest.

If you're going to mess with it, please use sparsemem, not discontigmem.
The intent is to deprecate and delete the latter.

M.

