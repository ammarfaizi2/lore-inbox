Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbTGJVVW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbTGJVVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:21:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55304 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266490AbTGJVVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:21:10 -0400
Date: Thu, 10 Jul 2003 22:35:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.75
Message-ID: <20030710223548.A20214@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>; from torvalds@osdl.org on Thu, Jul 10, 2003 at 02:14:15PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 02:14:15PM -0700, Linus Torvalds wrote:
> Ok. This is it. We (Andrew and me) are going to start a "pre-2.6" series,
> where getting patches in is going to be a lot harder. This is the last
> 2.5.x kernel, so take note.

Well, only two words from me.  Oh Shit.

The 2.5.70 ARM patch currently looks like this:

 343 files changed, 45388 insertions(+), 7341 deletions(-)

and I don't see that this will be reducing in size now that 2.6 is around
the corner.

I _know_ ARM stuff doesn't build and hasn't built in Linus' tree for a
fair time now - there are some generic changes to support ARM modules
needed in vmalloc.c which I just haven't had the time to sort out, and
there's still the issue of whether /proc/kcore actually works or not,
and now I see that the time stuff needs re-working for multiple ARM
platforms yet again.  (yes, all the other architectures got updated,
except for ARM.)

Maybe I should just forget even attempting to merge upstream, like most
of the ARM community doesn't.

Frustrated such an understatement.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

