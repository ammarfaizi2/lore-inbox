Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbSLPDco>; Sun, 15 Dec 2002 22:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSLPDco>; Sun, 15 Dec 2002 22:32:44 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:55188 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S264934AbSLPDcn>; Sun, 15 Dec 2002 22:32:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.5.50, ACPI] link error
Date: Sun, 15 Dec 2002 19:40:24 -0800
User-Agent: KMail/1.4.3
Cc: Pavel Machek <pavel@ucw.cz>, Jochen Hein <jochen@jochen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212062150.06350.EricAltendorf@orst.edu> <20021209072911.GA2934@zaurus>
In-Reply-To: <20021209072911.GA2934@zaurus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212151940.25024.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 December 2002 23:29, Pavel Machek wrote:
> Hi!
>
> > > > Right ... I'm no kernel hacker so I don't know why, but I can
> > > > only get the recent kernels to compile with sleep states if I
> > > > turn *ON* software suspend as well.  However, as soon as I
> > > > turn on swsusp and get a compiled kernel, it oops'es on boot.
> > >
> > > Can you mail me decoded oops?
> > > 								Pavel
> >
> > This is the first time I've decoded an oops, and since I had to
> > decode it on a different kernel (2.5.25) than the one I'm
> > debugging (2.5.50 + Dec 6 ACPI patch), and I couldn't
>
> Can you try passing
> "resume=hda5_or_whatever_your_swap_partition_is"?

Well, I've had "resume=/dev/hda6" in there the whole time (same as it 
was on prior kernels that booted).  I tried passing "resume=hda6" 
instead just for kicks and got the same result, though...  (This is 
still on the 2.5.50 + Dec6ACPI kernel)

Thanks,

Eric
-- 
"First they ignore you.  Then they laugh at you.
 Then they fight you.  And then you win."             -Gandhi
