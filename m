Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275277AbTHGLBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 07:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275283AbTHGLBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 07:01:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39179 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275277AbTHGLBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 07:01:04 -0400
Date: Thu, 7 Aug 2003 12:00:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Charles Lepple <clepple@ghz.cc>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: unable to suspend (APM)
Message-ID: <20030807120056.B17690@flint.arm.linux.org.uk>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Charles Lepple <clepple@ghz.cc>, linux-kernel@vger.kernel.org
References: <20030806231519.H16116@flint.arm.linux.org.uk> <3F31BDA3.7040700@ghz.cc> <20030807204553.3c5f432e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030807204553.3c5f432e.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Thu, Aug 07, 2003 at 08:45:53PM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 08:45:53PM +1000, Stephen Rothwell wrote:
> On Wed, 06 Aug 2003 22:46:59 -0400 Charles Lepple <clepple@ghz.cc> wrote:
> >
> > Also saw your post about the 3c59x cardbus adapter. I can't recall ever 
> > being able to suspend the machine with that card inserted (including 
> > under 2.4-- I always had to eject the card before suspend or hibernate). 
> 
> The IBM Thinkpad documentation mentions this (or used to) you cannot
> suspend a Thinkpad (using APM?) while there is a card powered in the
> PCMCIA/Cardbus slot.  You could try doing "cardctrl eject" before
> suspending - I find that this works for me (Thinkpad T22).
> 
> The message "apm: suspend: Unable to enter requested state" is an
> indication of an error from the BIOS.

Well, it all works fine with 2.4, even with a 3c59x in the slot (except
for the resume problem.)  Even ejecting the card before suspending with
2.6 doesn't fix the problem though.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

