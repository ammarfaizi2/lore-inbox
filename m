Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbTLMQmW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 11:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265143AbTLMQmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 11:42:21 -0500
Received: from [64.65.189.210] ([64.65.189.210]:50342 "EHLO
	mail.pacrimopen.com") by vger.kernel.org with ESMTP id S265078AbTLMQmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 11:42:20 -0500
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031213131836.GB11073@hh.idb.hist.no>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se>
	 <20031213131836.GB11073@hh.idb.hist.no>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1071333725.16407.22.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Dec 2003 08:42:05 -0800
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-13 at 05:18, Helge Hafting wrote:
> On Fri, Dec 12, 2003 at 03:18:03PM +0100, Måns Rullgård wrote:
> > Dale Mellor <dale@dmellor.dabsol.co.uk> writes:
> > 
> > > 1. Floppy motor spins when floppy module not installed.
> > 
> > It's a known problem.  Some broken BIOSes don't turn off the motor
> > after probing for a disk.  One solution is to change the boot priority
> > in the BIOS settings so the hard disk is tried before floppy.  If you
> > ever need to boot from a floppy, you can change it back.
> > 
> The kernel stops the spinning floppy _if_ you gives it a driver
> for the floppy hardware.
> 
> This is not a problem at all, considering that linux comes
> with such a driver.
> 
> Compile it in, or arranger for the module to be loaded at
> boot time.  You may of course arrange to unload it a little
> later if you want to save the memory.

This seems like the correct solution to me.

-- 
VB programmers ask why no one takes them seriously, 
it's somewhat akin to a McDonalds manager asking employees 
why they don't take their 'career' seriously.

