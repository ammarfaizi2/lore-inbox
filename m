Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUCVPe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUCVPe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:34:57 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:27410 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262062AbUCVPez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:34:55 -0500
Message-ID: <405F0B8D.8040408@techsource.com>
Date: Mon, 22 Mar 2004 10:51:41 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: David Schwartz <davids@webmaster.com>, Justin Piszcz <jpiszcz@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Microcode Question
References: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet>
In-Reply-To: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tigran Aivazian wrote:
> On Thu, 18 Mar 2004, David Schwartz wrote:
> 
>>	It is at least theoeretically possible that a microcode update might cause
>>an operation that's normally done very quickly (in dedicated hardware) to be
>>done by a slower path (microcode operations) to fix a bug in the dedicated
>>hardware
> 
> 
> Did you dream that up or did you read it somewhere? If the latter, where?
> 
> All operations are done by "dedicated hardware" and microcode DOES modify
> that hardware, or rather the way instructions are "digested". So, applying
> microcode doesn't make anything slower per se, it's just replacing one
> code sequence with another code sequence. If a new code happens to be
> slower than the old one then of course the result will be slower, but the
> reverse is also true. When you fix a bug in a particular software why
> should a bugfix be apriori slower than the original code? Think about it.
> 
> So please do not spread misinformation that applying microcode makes 
> something slower. If anything, it should make things faster, as long as 
> the guys at Intel are writing the correct (micro)code.

I don't see anything wrong with what he said.  As I understand it, 
Pentium 4 CPUs don't use microcode for much of anything.  If an 
instruction which was done entirely in dedicated hardware was buggy, and 
it's replaced by microcode, then it will most certainly be slower.

You seem to have missed where David used terms like "theoretically 
possible" and "an operation".

