Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318347AbSGRUQE>; Thu, 18 Jul 2002 16:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318346AbSGRUQD>; Thu, 18 Jul 2002 16:16:03 -0400
Received: from holomorphy.com ([66.224.33.161]:23692 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318347AbSGRUQD>;
	Thu, 18 Jul 2002 16:16:03 -0400
Date: Thu, 18 Jul 2002 13:18:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020718201857.GS1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk> <20020718010617.GL1096@holomorphy.com> <20020718142946.L13352@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020718142946.L13352@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 02:29:46PM +0100, Matthew Wilcox wrote:
>>>EIP; c01b7695 <visual_init+85/e0>   <=====
>>>edx; f7906600 <END_OF_CODE+37502e5c/????>
>>>edi; c03dcc00 <vc_cons+0/fc>
>>>esp; c3d45e7c <END_OF_CODE+39426d8/????>
> Trace; c01b7773 <vc_allocate+83/140>
> Trace; c01baa25 <con_open+19/88>
> Trace; c01ac08c <tty_open+20c/394>
> Trace; c0145a83 <link_path_walk+683/874>
> Trace; c0144ed7 <permission+27/2c>
> Trace; c0146373 <may_open+5f/2ac>
> Trace; c013c33a <chrdev_open+66/98>
> Trace; c013b001 <dentry_open+e1/1b0>
> Trace; c013af16 <filp_open+52/5c>
> Trace; c013b307 <sys_open+37/74>
> Trace; c0108893 <syscall_call+7/b>

This is the 4th one of these I've seen in the last two days. Any chance
of being able to compile with -g and get an addr2line on the EIP? I've
tried to reproduce it myself, but haven't gotten it to happen yet.

Thanks,
Bill
