Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTJCOzr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 10:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTJCOzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 10:55:47 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:37614 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S263742AbTJCOzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 10:55:44 -0400
Subject: Re: Floppy disk working constantly
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0310030909040.12482@chaos>
References: <1065186072.6517.44.camel@rade7.s.cs.auc.dk>
	 <Pine.LNX.4.53.0310030909040.12482@chaos>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1065192909.551.5.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 03 Oct 2003 16:55:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-03 at 15:14, Richard B. Johnson wrote:
> 
> What are you using as a boot loader? 

LILO.

> This may be a problem with
> the boot loader not turning off the floppy drive motor before
> it transfers control to Linux. With no built-in floppy driver,
> the motor would never turn off. With quick boot hard-disks,
> the floppy motor may still be ON from the initial BIOS access.
> 
> Just for kicks, change the order of boot devices in your
> BIOS so that the floppy is never accessed during boot. This
> should verify the problem.

That's it !

I try several time with and without the [boot floppy] option enabled in
the BIOS. Each time the [boot floppy] option was on, I got the floppy
driver to spin on endlessly.

Regards
-- 
Emmanuel

There's never enough time to do all the nothing you want.
  -- Calvin & Hobbes (Bill Waterson)

