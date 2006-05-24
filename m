Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWEXHax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWEXHax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWEXHaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:30:52 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:16038 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932633AbWEXHaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:30:52 -0400
Date: Wed, 24 May 2006 08:30:29 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060524073029.GA3314@srcf.ucam.org>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com> <E1Fifom-0003qk-00@chiark.greenend.org.uk> <4473BBEE.6030509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4473BBEE.6030509@garzik.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 09:50:38PM -0400, Jeff Garzik wrote:
> Matthew Garrett wrote:
> >In the long run, graphics drivers need to know how to program cards from 
> >scratch rather than depending on 80x25 text mod being there for them.
> 
> True in theory, but that's a task of immense proportions.  The Video 
> BIOS is often the only place where RAM timings and other board-specific 
> data lives.

We lose at ACPI support unless we can do this, unfortunately - the "run 
chunks of video BIOS" fallbacks aren't going to work forever.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
