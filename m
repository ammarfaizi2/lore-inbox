Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277768AbRJIPVk>; Tue, 9 Oct 2001 11:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277159AbRJIPV2>; Tue, 9 Oct 2001 11:21:28 -0400
Received: from hermes.toad.net ([162.33.130.251]:12705 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S277768AbRJIPVP>;
	Tue, 9 Oct 2001 11:21:15 -0400
Subject: Re: sysctl interface to bootflags?
From: Thomas Hood <jdthood@mail.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110091613490.32557-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.30.0110091613490.32557-100000@Appserv.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Oct 2001 11:21:14 -0400
Message-Id: <1002640876.1103.21.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I looked at your code and I saw that it depended
on ACPI.  Since ACPI doesn't work on my machine, I 
thought I should look for another solution.  However,
Alan now tells me that what I want to do can already
be done via /dev/nvram.

Thanks to both of you.
Thomas

On Tue, 2001-10-09 at 10:15, Dave Jones wrote:
> On 9 Oct 2001, Thomas Hood wrote:
> 
> > Would it be a good idea to do this using the sysctl infrastructure?
> > If so, can someone please suggest an appropriate pathname for
> > the flag files?  How about "/proc/sys/BIOS/bootflags/diagnostics"
> > and "/proc/sys/BIOS/bootflags/PnP-OS" ?
> > If this is a bad idea, someone please stop me before I waste my
> > time implementing it.
> 
> Last week, I pointed you at http://www.codemonkey.org.uk/sbf.c
> Can you give a reason why this needs to be done in kernel space ?
> 
> regards,
> 
> Dave.


