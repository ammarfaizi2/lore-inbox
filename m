Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWARDQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWARDQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWARDQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:16:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54248 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964884AbWARDQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:16:34 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Akinobu Mita <mita@miraclelinux.com>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 3/4] compact print_symbol() output 
In-reply-to: Your message of "Tue, 17 Jan 2006 22:05:27 CDT."
             <200601172208_MC3-1-B612-EE86@compuserve.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Jan 2006 14:15:52 +1100
Message-ID: <7483.1137554152@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert (on Tue, 17 Jan 2006 22:05:27 -0500) wrote:
>In-Reply-To: <200601171601.52995.ak@suse.de>
>
>On Tue, 17 Jan 2006 at 16:01:52 +0100, Andi Kleen wrote:
>
>> On Tuesday 17 January 2006 16:01, Hugh Dickins wrote:
>> 
>> > I've often found symbolsize useful.  Not when looking at an oops
>> > from my own machine.  But when looking at an oops posted on LKML,
>> > from someone who most likely has a different .config and different
>> > compiler, different optimization and different inlining from mine.
>> > symbolsize is a good clue as to how close their kernel is to the
>> > one I've got built on my machine, how likely guesses I make based
>> > on mine will apply to theirs, and whereabouts in the function that
>> > it oopsed.
>> 
>> Yes that is why I want it too.
>
>OK, how about this: remove the "0x" from the function size, i.e. print:
>
>        kernel_symbol+0xd3/10e
>
>instead of:
>
>        kernel_symbol+0xd3/0x10e
>
>This saves two characters per symbol and it should still be clear that
>the second number is hexadecimal.
>
>Does that break any tools?

Not, just CONFUSE-A-HUMAN (incorporating AMAZE-A-VOLE LTD, STUN-A-STOAT
LTD, PUZZLE-A-PUMA LTD, STARTLE-A-THOMPSON'S GAZELLE LTD,
BEWILDEREBEEST INC, DISTRACT-A-BEE).  Yes, I need a life.

