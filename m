Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTEIAKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTEIAKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:10:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:54151 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262219AbTEIAKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:10:19 -0400
Date: Thu, 8 May 2003 17:24:08 -0700
From: Greg KH <greg@kroah.com>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69: VIA IDE still broken
Message-ID: <20030509002408.GB4328@kroah.com>
References: <20030508220910.GA1070@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508220910.GA1070@codeblau.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 12:09:10AM +0200, Felix von Leitner wrote:
> Amazing: the only hardware components in my machine that actually work
> as expected with recent Linux 2.5 kernels are the network cards, the RAM
> and the keyboard, and I had to replace a tulip card with an eepro100 for
> that.  Even the CPU appears to run too hot with Linux, causing the
> system to boot spontaneously under load, and because ACPI is terminally
> broken in Linux and has been every time I tried it, I can't do much
> about it.  Firewire does not like me (modprobe eth1394 -> oops), IDE
> loses interrupts (see above), my USB mouse stops working as soon as I
> plug in my USB hard disk (which works fine on my notebook and under
> Windows), using my IDE CD-R causes the machine to freeze while cdrecord
> does OTP, finalizing or eject.  The nvidia graphics card takes major
> patching to work at all with X, and all of these components are
> well-known brand components from tier 1 suppliers that were chosen for
> reliability and market penetration over price.  I envy people who can
> still evangelize Linux under circumstances like this.  I sure as hell
> can not.

Have you filed bugs in bugzilla.kernel.org for these issues so that the
developers can know about them to fix them?

thanks,

greg k-h
