Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTI3PsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbTI3PsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:48:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:9184 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261602AbTI3PsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:48:17 -0400
Date: Tue, 30 Sep 2003 08:48:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Valdis.Kletnieks@vt.edu
cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -mregparm=3 (was Re: [PATCH] i386 do_machine_check() is redundant.
In-Reply-To: <200309301529.h8UFTNvl019529@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0309300847220.13584-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Sep 2003 Valdis.Kletnieks@vt.edu wrote:
> 
> Well, they do have an open interface.  I've apparently just not gotten all the
> __attribute((regparm(0))) in the right places yet. ;)

They may have some places inside the binary part that call directly out 
to the kernel, and use the wrong calling conventions. 

		Linus

