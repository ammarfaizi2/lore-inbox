Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUHFOXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUHFOXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268062AbUHFOXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:23:53 -0400
Received: from ida.rowland.org ([192.131.102.52]:56324 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S268059AbUHFOXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:23:52 -0400
Date: Fri, 6 Aug 2004 10:23:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Michael Guterl <mguterl@gmail.com>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>,
       =?ISO-8859-1?Q?Luis_Miguel_Garc=FD_Mancebo?= <ktech@wanadoo.es>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
In-Reply-To: <944a037704080420574bb181f8@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0408061020450.3136-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Michael Guterl wrote:

> Okay, due to my lack of detail from previous posts, I thought I'd
> restate everything with a little more detail.  Previously I was using
> 2.6.7-mm7 (bk-acpi.patch and bk-usb.patch were reversed), everything
> worked fine.  Upgraded to 2.6.8-rc2 and my machine would just stop at
> starting cupsd.  Previous to reversing bk-acpi.patch and bk-usb.patch,
> 2.6.7-mm7 showed the same behavior.  I unplugged all my USB devices,
> and booted, and 2.6.8-rc2 started fine.  I plugged in the keyboard and
> I tried to use the keyboard and the result was whichever key was
> pressed, that character was repeated numerous times.  No matter what I
> could not get a single character to appear, the always appeared like
> "sssssssssssssssssssssss".  Went and grabbed an old PS/2 Keyboard, and
> proceeded to gather the information David Brownell suggested.

To me this suggests you may be seeing a problem with ACPI, not USB.  
That's the only way to explain why starting cupsd could lead to problems.

For more information, you could try turning on the USB debugging option in
your kernel's configuration.

Alan Stern

