Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUKDGRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUKDGRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbUKDGRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:17:49 -0500
Received: from web26102.mail.ukl.yahoo.com ([217.12.10.226]:55971 "HELO
	web26102.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262085AbUKDGRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:17:45 -0500
Message-ID: <20041104061744.84541.qmail@web26102.mail.ukl.yahoo.com>
Date: Thu, 4 Nov 2004 07:17:44 +0100 (CET)
From: Roland Kaeser <roli8200@yahoo.de>
Subject: Re: [uml-user] Harddisk Shutdown while UML Guest Shutdown
To: Chris Wedgwood <cw@f00f.org>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>,
       user-mode-linux-user@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041104005145.GB17583@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

To Your questions:

> does this happen w/o the SKAS patch?
I don't have tried it. I will do it today

> uml is triggering a host OS bug
A host OS bug? How can I get this out from the machine?

As I wrote in a later mail, at the time the harddisk spins down, the uml kernel
causes a memory error. (German: Speicherfehler) core dump.

I will try to setup a test machine which You can access to test it by Yourself, I
think i can't discribe it completely enough to give You a point for a solution.

Roland


 --- Chris Wedgwood <cw@f00f.org> schrieb: 
> On Wed, Nov 03, 2004 at 08:21:55PM +0100, Roland Kaeser wrote:
> 
> > And no, the HOST!! freezes after exit of the guest kernel.
> 

> 
> > And i get a Kernel panic from the HOST!! kernel, this in case the
> > host (ide) harddisk drive spins down (but not spins up anymore).
> 
> oops details please
> 
> > My idea is that some routines to spin down the harddisk are been
> > routed outside the uml guest kernel or not been sucessfully removed
> > for the uml architecture.
> 
> unlikely, uml catches the ioctls hdparm uses (i have a patch for this
> cleaning things up somewhere or maybe it got merged).  uml shouldn't
> propagate the ioctls out
> 
> > Is it possible that the /sbin/halt binary can have made something
> > with the hosts harddisk?
> 
> not directly, but it might trigger something

> 
> > How can i get the kernel panic message from the host?
> 
> uml is triggering a host OS bug
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
>  


	

	
		
___________________________________________________________
Gesendet von Yahoo! Mail - Jetzt mit 100MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
