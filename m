Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTJKR5u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbTJKR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:57:50 -0400
Received: from mail1.mail.iol.ie ([194.125.2.192]:59824 "EHLO
	mail1.mail.iol.ie") by vger.kernel.org with ESMTP id S263345AbTJKR5r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:57:47 -0400
Date: Sat, 11 Oct 2003 18:57:44 +0100
From: Kenn Humborg <kenn@linux.ie>
To: asdfd esadd <retu834@yahoo.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model
Message-ID: <20031011175744.GA15610@excalibur.research.wombat.ie>
References: <200310111430.h9BEUX6s019836@turing-police.cc.vt.edu> <20031011160621.22378.qmail@web13006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011160621.22378.qmail@web13006.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 09:06:21AM -0700, asdfd esadd wrote:
> 
> the other OS has an at this stage highly consistent
> object model user along the lines of COM+ from the
> kernel up encompassing a single event, thread etc.
> model. Things are quite consistently wrapped, user
> mode exposed if needed etc. If people were to fully
> draw on it and the simpler .net BCL and not ride win32
> that would (will be) a killer.  

I'm a Win32 developer by day, and I'm pretty familiar with
the innards of COM.  But I can't think of a _single_ instance
of anything in COM or COM+ which is dependent on the kernel,
or which lives on the kernel-side of the kernel-mode/usr-mode
boundary.

COM and COM+ (and even .NET) are user-mode libraries and
conventions.

The closest thing _inside_ the WinNT/2K/XP kernel to your
"object model" is the hierarchical directory of refcounted
and ACLed objects inside the kernel (which is basically sysfs
with ACLs).

Can you give me _one_ example of a "consistent object model"
between kernel and user mode in Windows?  Maybe then we'll
have a better understanding of what you're really looking
for.

Later,
Kenn


