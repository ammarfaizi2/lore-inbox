Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269020AbUJKPBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269020AbUJKPBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269048AbUJKPBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:01:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:22410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269043AbUJKO5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:57:51 -0400
Date: Mon, 11 Oct 2004 07:57:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Brice.Goglin@ens-lyon.org
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
In-Reply-To: <416A4D67.9070108@ens-lyon.fr>
Message-ID: <Pine.LNX.4.58.0410110752380.3897@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
 <416A4D67.9070108@ens-lyon.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Brice Goglin wrote:
> 
> Well, I have one (N600c).
> What am I supposed to see ? Is there anything special to do ?

Different Evo, different BIOS, different AML bug. You might try to update 
your BIOS, it might be fixed.

> I don't know exactly how fan control is supposed to be fixed.
> Automatic wakeup/stop of these fans depending on the temperature
> was already working.

It wasn't on the N620c.. That one had errors like

    ACPI-1133: *** Error: Method execution failed [\_TZ_.C202] (Node c1926af0), AE_AML_NO_RETURN_VA
    ACPI-1133: *** Error: Method execution failed [\_TZ_.C20C._STA] (Node c1926cd4), AE_AML_NO_RETU

but yours are different:

> By the way, I still see these errors during the boot, don't know if it's
> supposed to be fixed :
> 
>   psparse-1133: *** Error: Method execution failed [\_SB_.C03E.C053.C0D1.C12E] (Node e7f9a3a8), AE_AML_UNINITIALIZED_LOCAL
>   psparse-1133: *** Error: Method execution failed [\_SB_.C03E.C053.C0D1.C13D] (Node e7f9bd68), AE_AML_UNINITIALIZED_LOCAL
>   psparse-1133: *** Error: Method execution failed [\_SB_.C19F._BTP] (Node e7fa3348), AE_AML_UNINITIALIZED_LOCAL

Have you made a acpi bugzilla entry for this?

		Linus
