Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVB1J7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVB1J7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 04:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVB1J7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 04:59:52 -0500
Received: from hornet.berlios.de ([195.37.77.140]:7583 "EHLO hornet.berlios.de")
	by vger.kernel.org with ESMTP id S261568AbVB1J7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 04:59:49 -0500
Date: Mon, 28 Feb 2005 10:59:35 +0100
From: mhf@berlios.de
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org, James@superbug.demon.co.uk
Subject: Re: [BUG] 2.6.11-rc[234] setfont fails on i810 after resume from 
 ACPI-S3
Message-ID: <4222EB87.nailFAE1RJ6JS@berlios.de>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 February 2005 17:59, Pavel Machek wrote:
> Hi!
>
> > >Well, dumping random stuff to console can produce
> > > funny results. I'd call that normal. Try cat
> > > /dev/urandom, that should be "enough random".
> >
> > I am also getting strange effects. I boot into 
> > 2.6.11-rc4 and the console fonts looks fine. Come back
> > a day later and the console font has corrupt
> > characters. E.g. Displays a "D" instead of an "L" and
> > stuff like that. It is mostly readable, except for a
> > few characters. It is only the local console that is
> > corrupted. ssh into the box displays correct
> > characters, so all I can assume is that the VGA console
> > is being programmed with different characters. The bad
> > characters also survive a soft reboot( During BIOS boot
> > up), until the linux kernel starts booting, and then it
> > switches to a good font.
>
> I have seen something similar on S3 cards with bad video
> ram (we had
>
> >3 of them). If it survives soft reboot... well, that
> > looks like
>
> hardware problem to me. [We may do something bad in
> linux, too, but strange effects should not survive
> reboot, that's hw bug. I'd suggest memtest on video ram,
> but someone would need to write that tool, first].
>
>         Pavel

i810 uses system RAM (which was tested with memtest)

In my case, it also does work fine with 2.4.29, thus problem 
2.6 specific.


 Michael
