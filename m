Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbTFLS4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbTFLS4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:56:52 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:63721 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264948AbTFLS4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:56:51 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Michel Alexandre Salim <mas118@york.ac.uk>
Subject: Re: Broken USB, sound in 2.5.70-mmX series
Date: Thu, 12 Jun 2003 21:10:10 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <1055436599.6845.7.camel@bushido> <200306122002.55017.oliver@neukum.org> <1055443509.6143.15.camel@bushido>
In-Reply-To: <1055443509.6143.15.camel@bushido>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306122110.10207.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 12. Juni 2003 20:45 schrieb Michel Alexandre Salim:
> On Thu, 2003-06-12 at 19:02, Oliver Neukum wrote:
> > > It is definitely ACPI - I tried booting with ACPI off, everything works
> > > (sound stutters though). Booting with ACPI, the sound driver is not
> > > loaded. Manually loading, sound stuttered then stopped after one
> > > second. Keyboard and mouse (both USB) do not work with ACPI even though
> > > the drivers are loaded.
> >
> > Do you see irqs for USB if you boot with acpi?
>
> Everything's on IRQ 9. That's why sound is broken as well it seems - IRQ
> sharing does not work as well as it should.

Did you try using pci= on the command line?

	Regards
		Oliver

