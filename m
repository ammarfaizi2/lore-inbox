Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUCRJ1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUCRJ1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:27:43 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:40137 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262455AbUCRJ1m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:27:42 -0500
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong
	thing
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: Peter Williams <peterw@aurema.com>
Cc: christian.guggenberger@physik.uni-regensburg.de,
       Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <40594ADE.2020804@aurema.com>
References: <1079593351.1830.12.camel@bonnie79>
	 <40594ADE.2020804@aurema.com>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1079601925.26668.2.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 10:25:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 08:08, Peter Williams wrote:
> Christian Guggenberger wrote:
> >>With 2.6.4 I'm getting the following messages very early in the boot 
> >>long before XFree86 is started:
> >>
> >>Mar 18 16:05:31 mudlark kernel: atkbd.c: Unknown key released 
> >>(translated set 2, code 0x7a on isa0060/serio0).
> >>Mar 18 16:05:31 mudlark kernel: atkbd.c: This is an XFree86 bug. It 
> >>shouldn't access hardware directly.
> >>
> >>They are repeated 6 times and are NOT the result of any keys being 
> >>pressed or released.
> > 
> > 
> > this has been fixed in XFree86 HEAD (4.4.99.1)
> > see changelog entry nr. 6 - the changes can easily be backported to 4.3.0, and work as expected on my box.
> > (no noise anymore)
> 
> I repeat.  These messages are appearing when XFree86 is NOT running so 
> there is no way that it can be the cause of them.

I have the exact same behaviour on my machine.

(my 2 cents)

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

