Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWH2J5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWH2J5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWH2J5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:57:14 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:18123 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S964868AbWH2J5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:57:08 -0400
Message-Id: <44F42BB1.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 29 Aug 2006 11:57:37 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <petkov@math.uni-muenster.de>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
References: <20060820013121.GA18401@fieldses.org>
 <44E97353.76E4.0078.0@novell.com> <20060829085338.GA8225@gollum.tnic>
In-Reply-To: <20060829085338.GA8225@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Borislav Petkov <bbpetkov@yahoo.de> 29.08.06 10:53 >>>
>Hi,
>    I just read that unwinder thread and I think I have yet another case of
>    unwinder backtrace that comes up together with the recursive deadlock
>    protection backtrace and this happens with 18-rc5 so I thought I should
>    report it before .18 is released:
>...
>Aug 29 10:21:22 zmei kernel: [  383.485261]  [<c0105393>] do_IRQ+0xc3/0xd0
>Aug 29 10:21:22 zmei kernel: [  383.489393]  [<c0103521>] common_interrupt+0x25/0x2c
>Aug 29 10:21:22 zmei kernel: [  383.494387] DWARF2 unwinder stuck at common_interrupt+0x25/0x2c
>Aug 29 10:21:22 zmei kernel: [  383.500304] Leftover inexact backtrace:
></snip>

Unfortunately this leaves unclear whether there was anything reported in
the leftover portion.
And in all cases, a sufficiently long raw stack trace is needed to analyse this.
Ideally a matching System.map would also be attached.

Jan

