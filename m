Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbTDXJ72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbTDXJ72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:59:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50692 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262637AbTDXJ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:59:22 -0400
Date: Thu, 24 Apr 2003 11:11:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Message-ID: <20030424111123.A25304@flint.arm.linux.org.uk>
Mail-Followup-To: DevilKin <devilkin-lkml@blindguardian.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <200304230747.27579.devilkin-lkml@blindguardian.org> <200304240940.21553.devilkin-lkml@blindguardian.org> <20030424085756.A9597@flint.arm.linux.org.uk> <200304241206.43717.devilkin-lkml@blindguardian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304241206.43717.devilkin-lkml@blindguardian.org>; from devilkin-lkml@blindguardian.org on Thu, Apr 24, 2003 at 12:06:37PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 12:06:37PM +0200, DevilKin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Thursday 24 April 2003 09:57, Russell King wrote:
> > Maybe looking in /sysfs/bus/pci/drivers before inserting the card
> > (this may cause an oops as well - if so, it confirms my suspicion.)
> 
> Uh... The Maestro3 is integrated on the motherboard, so that's kinda hard.

Sorry, I meant booting without the cardbus card inserted, then looking
at /sysfs/bus/pci/drivers.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

