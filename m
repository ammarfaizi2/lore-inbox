Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWGVGh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWGVGh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 02:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWGVGh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 02:37:29 -0400
Received: from mail.gmx.net ([213.165.64.21]:12945 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932084AbWGVGh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 02:37:28 -0400
X-Authenticated: #914056
Date: Fri, 21 Jul 2006 21:45:04 +0200
From: Tino Keitel <tino.keitel@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: thinkpad x60s: middle button doesn't work after hibernate
Message-ID: <20060721194502.GA5727@localhost>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <44BFD911.70106@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BFD911.70106@cmu.edu>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 15:27:13 -0400, George Nychis wrote:
> Hey guys,
> 
> I recently got the suspend to disk working and suspend to memory working
> thanks to many of you.  Whenever I suspend to disk and resume, the
> middle mouse button on my thinkpad x60s no longer works for scrolling or

I observed the same on my T23.

> for pasting.  I either have to reboot, or suspend to memory and resume.
>  Therefore:
> 
> Initial Boot: working
> Suspend to disk -> resume: not working
> Suspend to memory -> resume: working

Thanks, that really works. I never tried to suspend to RAM after
hibernation.

> 
> To fix it for now, i simply suspend to memory and resume after resuming
> a suspend to disk.

Unfortunately, I need a framebuffer console for the suspend2 progress
display (text mode progress display didn't work), and savagefb has
issues with hibernation, and vesafb is garbled after suspend to RAM.

> 
> Anyone else experience this?

Me.

Regards,
Tino
