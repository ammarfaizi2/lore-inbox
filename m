Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbTHYRQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTHYRQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:16:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53004 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261572AbTHYRQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:16:24 -0400
Date: Mon, 25 Aug 2003 18:16:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, torvalds@osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030825181621.G16790@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Pavel Machek <pavel@ucw.cz>, torvalds@osdl.org,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030823114738.B25729@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308250840360.1157-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308250840360.1157-100000@cherise>; from mochel@osdl.org on Mon, Aug 25, 2003 at 08:47:16AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 08:47:16AM -0700, Patrick Mochel wrote:
> That's fine. I will fix PCMCIA, as I have devices to test with. I have no 
> ARM devices (nor do I want any). I can take a stab, but won't guarantee 
> anything. Could you tell me, though, when/if these devices did work with 
> what power management scheme? APM? 

I omitted to say that I've fixed up most of the non-platform based
PCMCIA socket drivers.  However, this set of patches is waiting on
a response from gregkh/jgarzik on a fix to the PCI save/restore state
handling.

In any case, we need to get the platform device situation resolved by
public discussion before making any code changes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

