Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbTI3Pst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbTI3Pst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:48:49 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39174
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261607AbTI3PsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:48:24 -0400
Subject: Re: -mregparm=3 (was Re: [PATCH] i386 do_machine_check() is
	redundant.
From: Robert Love <rml@tech9.net>
To: Valdis.Kletnieks@vt.edu
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200309301437.h8UEbSvl017305@turing-police.cc.vt.edu>
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org>
	 <1064775868.5045.4.camel@laptop.fenrus.com>
	 <Pine.LNX.4.58.0309292214100.3276@artax.karlin.mff.cuni.cz>
	 <20030929202604.GA23344@nevyn.them.org>
	 <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz>
	 <200309300449.h8U4nSvl002308@turing-police.cc.vt.edu>
	 <1064897712.4568.32.camel@localhost>
	 <200309301437.h8UEbSvl017305@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1064936898.4568.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Tue, 30 Sep 2003 11:48:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 10:37, Valdis.Kletnieks@vt.edu wrote:

> Well, abs() is the only one I tripped over in my config.  I'm sure there's others
> lurking elsewhere in the kernel tree.

There are not _too_ many builtins.  abs, strcpy, et cetera ...

> The bigger question is whether a patch to support -ffreestanding would be a
> good idea - with proper use of the __builtin_* stuff it *should* work, and it will
> hopefully cause better kernel code hygiene..

I agree.  We should go for it.

	Robert Love


