Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbTBJP7H>; Mon, 10 Feb 2003 10:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTBJP7H>; Mon, 10 Feb 2003 10:59:07 -0500
Received: from 12-252-67-253.client.attbi.com ([12.252.67.253]:41372 "EHLO
	morningstar.nowhere.lie") by vger.kernel.org with ESMTP
	id <S264875AbTBJP7G>; Mon, 10 Feb 2003 10:59:06 -0500
From: "John W. M. Stevens" <john@betelgeuse.us>
Date: Mon, 10 Feb 2003 09:08:48 -0700
To: James Buchanan <jamesbuch@iprimus.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP-Linux
Message-ID: <20030210160848.GB30804@morningstar.nowhere.lie>
References: <001501c2d11a$3ad9c3a0$59951ad3@windows>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001501c2d11a$3ad9c3a0$59951ad3@windows>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 02:36:48AM +1100, James Buchanan wrote:
> Is it possible to design a SMP-Linux kernel with architecture
> independent SMP support, for example, like the VFS provides an
> interface to specific filesystems, the "VSMP" can provide an
> architecture independent way to support SMP?

Why stop there?  Why not make a complete hardware abstraction layer?

Oh, by the way, I have two words for you:

DUCK!

:-)

> There can be a function
> that does the spinlock stuff and underneath is a machine dependent
> implementation (this is already done for x86, what about other MP
> capable architectures?), and same for the scheduler.  Lots of other
> stuff like TLB issues and so on would have to be taken care of as
> well.  I'm no expert on SMP so I don't really know if a "virtual" SMP
> support is possible in the way I am describing it.

What you are describing sounds very much like a Virtual Machine.

Been there, done that, and it does have some benefits.

Good Luck,
John S.
