Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbTISFvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 01:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTISFvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 01:51:46 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:42990 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261327AbTISFvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 01:51:45 -0400
Subject: Re: Make modules_install doesn't create /lib/modules/$version
From: Martin Schlemmer <azarah@gentoo.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, rob@landley.net,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030919024455.834992C0F1@lists.samba.org>
References: <20030919024455.834992C0F1@lists.samba.org>
Content-Type: text/plain
Message-Id: <1063950080.5491.10.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 19 Sep 2003 07:41:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-19 at 04:25, Rusty Russell wrote:
> In message <20030918091511.276309a6.rddunlap@osdl.org> you write:
> > On Thu, 18 Sep 2003 03:21:40 -0400 Rob Landley <rob@landley.net> wrote:
> > 
> > | I've installed -test3, -test4, and now -test5, and each time make 
> > | modules_install died with the following error:
> > | 
> > | Kernel: arch/i386/boot/bzImage is ready
> > | sh arch/i386/boot/install.sh 2.6.0-test5 arch/i386/boot/bzImage System.map ""
> > | /lib/modules/2.6.0-test5 is not a directory.
> 
> Looks like arch/i386/boot/install.sh is calling ~/bin/installkernel or
> /sbin/installkernel, which is not creating the directory.
> 
> Should depmod create the directory?  It can, of course, but AFAICT the
> old one didn't.
> 
> Maybe a RedHat issue?
> 

Likely, it works fine here with the one we are using
from debianutils.


Regards,

-- 
Martin Schlemmer


