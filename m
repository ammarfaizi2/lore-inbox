Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269227AbUJKUXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269227AbUJKUXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbUJKUXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:23:11 -0400
Received: from 106.80-203-35.nextgentel.com ([80.203.35.106]:36976 "EHLO
	home.gnome.no") by vger.kernel.org with ESMTP id S269227AbUJKUXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:23:06 -0400
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
From: Kjartan Maraas <kmaraas@broadpark.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Brice.Goglin@ens-lyon.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410110752380.3897@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
	 <416A4D67.9070108@ens-lyon.fr>
	 <Pine.LNX.4.58.0410110752380.3897@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Oct 2004 22:22:47 +0200
Message-Id: <1097526167.10001.0.camel@home.gnome.no>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 11,.10.2004 kl. 07.57 -0700, skrev Linus Torvalds:
> 
> On Mon, 11 Oct 2004, Brice Goglin wrote:
> > 
> > Well, I have one (N600c).
> > What am I supposed to see ? Is there anything special to do ?
> 
> Different Evo, different BIOS, different AML bug. You might try to update 
> your BIOS, it might be fixed.
> 
The latest BIOS didn't make a difference for me at least.

> > I don't know exactly how fan control is supposed to be fixed.
> > Automatic wakeup/stop of these fans depending on the temperature
> > was already working.
> 
> It wasn't on the N620c.. That one had errors like
> 
>     ACPI-1133: *** Error: Method execution failed [\_TZ_.C202] (Node c1926af0), AE_AML_NO_RETURN_VA
>     ACPI-1133: *** Error: Method execution failed [\_TZ_.C20C._STA] (Node c1926cd4), AE_AML_NO_RETU
> 
> but yours are different:
> 
> > By the way, I still see these errors during the boot, don't know if it's
> > supposed to be fixed :
> > 
> >   psparse-1133: *** Error: Method execution failed [\_SB_.C03E.C053.C0D1.C12E] (Node e7f9a3a8), AE_AML_UNINITIALIZED_LOCAL
> >   psparse-1133: *** Error: Method execution failed [\_SB_.C03E.C053.C0D1.C13D] (Node e7f9bd68), AE_AML_UNINITIALIZED_LOCAL
> >   psparse-1133: *** Error: Method execution failed [\_SB_.C19F._BTP] (Node e7fa3348), AE_AML_UNINITIALIZED_LOCAL
> 
> Have you made a acpi bugzilla entry for this?
> 
I made one a while ago:

http://bugzilla.kernel.org/show_bug.cgi?id=1404

Cheers
Kjartan

