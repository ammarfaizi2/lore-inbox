Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTLMNHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 08:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTLMNHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 08:07:32 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:53265 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264966AbTLMNHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 08:07:30 -0500
Date: Sat, 13 Dec 2003 14:18:36 +0100
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
Message-ID: <20031213131836.GB11073@hh.idb.hist.no>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xd6auyvac.fsf@kth.se>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 03:18:03PM +0100, Måns Rullgård wrote:
> Dale Mellor <dale@dmellor.dabsol.co.uk> writes:
> 
> > 1. Floppy motor spins when floppy module not installed.
> 
> It's a known problem.  Some broken BIOSes don't turn off the motor
> after probing for a disk.  One solution is to change the boot priority
> in the BIOS settings so the hard disk is tried before floppy.  If you
> ever need to boot from a floppy, you can change it back.
> 
The kernel stops the spinning floppy _if_ you gives it a driver
for the floppy hardware.

This is not a problem at all, considering that linux comes
with such a driver.

Compile it in, or arranger for the module to be loaded at
boot time.  You may of course arrange to unload it a little
later if you want to save the memory.

Helge Hafting 
