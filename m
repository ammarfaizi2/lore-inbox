Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbUKDCSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUKDCSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUKDCRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:17:46 -0500
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:36509 "EHLO
	tyo206.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261174AbUKDCQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:16:48 -0500
To: Valdis.Kletnieks@vt.edu
Cc: "Giacomo A. Catenazzi" <cate@debian.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
References: <41894779.10706@techsource.com>
	<20041103211714.GP12275@mea-ext.zmailer.org>
	<41894F86.7070405@debian.org>
	<200411032157.iA3LvA4i019705@turing-police.cc.vt.edu>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 04 Nov 2004 11:16:23 +0900
In-Reply-To: <200411032157.iA3LvA4i019705@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Wed, 03 Nov 2004 16:57:10 -0500")
Message-ID: <buois8me4ug.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:
> However, the problem is that I probably want to compile a working
> kernel *now*, not when the GCC people finally get around to fixing
> the b0rkedness they added for my architecture in gcc 3.2.3.

Yup, this is particuarly true with fringe architectures.

E.g., you're using a compiler for your CPU that has changes not in
mainstream gcc, the vendor who made them is slow in updating to new gcc
versions, and their changes are complex enough that you don't want to
spend the manpower to port them yourself.

You've got the GPL, so of course it's of course _possible_ to do the
work yourself and get a newer gcc working, but sometimes it's really
nice to also have the option _not_ to do that...

-Miles
-- 
((lambda (x) (list x x)) (lambda (x) (list x x)))
