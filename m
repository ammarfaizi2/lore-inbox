Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275298AbTHSBcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275300AbTHSBcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:32:16 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:1665
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S275298AbTHSBcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:32:12 -0400
Date: Mon, 18 Aug 2003 21:31:20 -0500 (CDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       <linux-pcmcia@lists.infradead.org>
Subject: Re: [CFT] Clean up yenta_socket
In-Reply-To: <20030817153435.A24478@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308182126090.1198-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003, Russell King wrote:

> Patch set:
> 
> 	http://patches.arm.linux.org.uk/pcmcia/yenta-20030817*
> 
> 	The tar file contains all patches.
> 
> This is a patch set aimed to cleaning up the yenta controller quirks,
> working around some of the warts which have appeared (eg, overwriting
> of yenta_operations init pointer.) and adding better power management
> support.
> 
> Unfortunately, since my laptop continues to have an argument with the
> 2.6 kernel APM, I am unable to properly test the suspend/hibernate/resume
> functionality.

I applied the patchset to 2.6.0-test3-mm2 and compiled.  Other than some 
extra lines in dmesg output no user observable change in behaviour was 
noted.  In other words I couldn't see any differences between using this 
patchset and using stock yenta code.  

Never having used the suspend/hibernate/resume on my laptop I could 
neither test nor comment on that aspect.  Sorry about that.

My laptop is a Presario 12XL325 and I use an SMC 2632W wireless ethernet 
adapter in the PCMCIA slot.  

