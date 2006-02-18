Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWBRUvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWBRUvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 15:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWBRUvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 15:51:16 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:38283 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932159AbWBRUvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 15:51:15 -0500
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sat, 18 Feb 2006 12:51:09 -0800
User-Agent: KMail/1.7.1
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
References: <200602131116.41964.david-b@pacbell.net> <43F0E724.6000807@cfl.rr.com> <20060215234317.GC3490@openzaurus.ucw.cz>
In-Reply-To: <20060215234317.GC3490@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602181251.09865.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 3:43 pm, Pavel Machek wrote:
> 
> > Are you quite certain about that?  This is not 
> > the case for SCSI disks, but for USB, maybe it 
> > can provide sufficient information to the 
> > kernel about state changes without having to do 
> > a full rescan.  If that is the case, and the 
> > hardware is erroneously reporting that all 

Hardware is CORRECTLY reporting electrical disconnects,
but Philip is wanting Linux to ignore those reports.


> > devices were disconnected and reconnected after 
> > an ACPI suspend to disk, then such hardware is 
> > broken and the kernel should be patched to work 
> > around it. 
> 
> No patch was attached...

No patch possible.  Reading the other messages in that
thread, Philip is advocating Linux ignore the USB spec.
(Which is what _he_ appears to have been doing...)

What he has to do is more than submit a patch.  He first
needs to lobby the USB-IF to change the USB spec, and
get every peripheral vendor to stop shipping USB devices
and instead switch over to "Philip-USB".  Then get all
the billions of USB peripherals to go into the recycle
bin and be replaced with products conforming to his
new variant.  It all seems highly unlikely.  ;)


But yes, you're right ... if he's serious about
changing all that stuff, he also needs stop being a
member of the "never submitted a USB patch" club.
Ideally, starting with small things.

