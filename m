Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSLAMOp>; Sun, 1 Dec 2002 07:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbSLAMOp>; Sun, 1 Dec 2002 07:14:45 -0500
Received: from smtp02.wxs.nl ([195.121.6.54]:34186 "EHLO smtp02.wxs.nl")
	by vger.kernel.org with ESMTP id <S261646AbSLAMOp>;
	Sun, 1 Dec 2002 07:14:45 -0500
Subject: Re: APM issues
From: Thomas Hood <jdthood@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Cc: "Tristan O'Tierney" <teo2604@cs.rit.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1038745351.2627.195.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 01 Dec 2002 13:22:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tristan O'Tierney" wrote:
> in kernel 2.4.20 my laptop fails to awaken after
> that command [apm -s].

There are changes to arch/i386/kernel/apm.c in
2.4.20, but they mainly concern support for SMP.

Did you upgrade XFree86 recently?
Does resume work if you suspend with X not running?
What exactly happens when you request a resume?  Do
you see anything in the log?

What laptop model do you have?
What distro are you using?

> Even worse in kernel 2.5.x apm completely fails to load.

Are you trying to load apm as a module?  Perhaps you
should wait for the 2.5 module loading code to settle down.
Then write again and provide more details of the problem.

> Why is it getting progressively worse?

Because Linux 2.5 is a development kernel.

-- 
Thomas Hood <jdthood@yahoo.co.uk>

