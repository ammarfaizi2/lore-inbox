Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTI3ITv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbTI3ITv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:19:51 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:16902 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261216AbTI3ITt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:19:49 -0400
Message-ID: <3F793EB8.7010605@aitel.hist.no>
Date: Tue, 30 Sep 2003 10:28:40 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -mregparm=3 (was  Re: [PATCH] i386 do_machine_check() is redundant.
References: <Pine.LNX.4.44.0309291142430.3626-100000@home.osdl.org> <200309291954.h8TJsm6p002210@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> Quite correct - even after recompiling the sourced portions of the NVidia
> driver, it dies a horrid death on 'insmod' when the closed-source portion
> passes a parameter on the stack and the open side expects the value in a
> register, and follows the register value to a quick death....
> 
Nvidia can fix this easily. Either by having several versions of
their closed-source thing, or by having a open "interface" that
uses nvidia's calling convention for talking to their proprietary
binary code, and whatever the kernel uses for talking to the kernel.
That's the price of binary modules -
One extra level of indirection, or a bunch of different modules.
Of course there are plenty of other cards without
such problems.

Helge Hafting

