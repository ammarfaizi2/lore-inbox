Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTEIIqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbTEIIqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:46:13 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:31126 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262378AbTEIIqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:46:12 -0400
To: Timothy Miller <miller@techsource.com>
Cc: root@chaos.analogic.com, Roland Dreier <roland@topspin.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305070933450.11740@chaos>
	<20030507135657.GC18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305071008080.11871@chaos>
	<p05210601badeeb31916c@[207.213.214.37]>
	<Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
	<Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com>
	<Pine.LNX.4.53.0305071523010.13724@chaos> <52n0hyo85x.fsf@topspin.com>
	<Pine.LNX.4.53.0305071547060.13869@chaos>
	<3EB96FB2.2020401@techsource.com>
	<Pine.LNX.4.53.0305080729410.16638@chaos>
	<3EBA7AE2.9020401@techsource.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 09 May 2003 17:57:00 +0900
In-Reply-To: <3EBA7AE2.9020401@techsource.com>
Message-ID: <buou1c4v6oz.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> writes:
> That is to say, some CPUs might have provision for a stack pointer to be 
> associated with each interrupt vector.

On my arch, the CPU doesn't use the stack for interrupts at all...
so any saving on the stack is what's done by entry.S.

-Miles
-- 
o The existentialist, not having a pillow, goes everywhere with the book by
  Sullivan, _I am going to spit on your graves_.
