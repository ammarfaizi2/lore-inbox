Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTFLSdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbTFLScV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:32:21 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:14540 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S264940AbTFLSas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:30:48 -0400
Subject: Re: Broken USB, sound in 2.5.70-mmX series
From: Michel Alexandre Salim <mas118@york.ac.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306122002.55017.oliver@neukum.org>
References: <1055436599.6845.7.camel@bushido>
	 <1055437375.6143.2.camel@bushido>  <200306122002.55017.oliver@neukum.org>
Content-Type: text/plain
Organization: University of York
Message-Id: <1055443509.6143.15.camel@bushido>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 19:45:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 19:02, Oliver Neukum wrote:
> > It is definitely ACPI - I tried booting with ACPI off, everything works
> > (sound stutters though). Booting with ACPI, the sound driver is not
> > loaded. Manually loading, sound stuttered then stopped after one second.
> > Keyboard and mouse (both USB) do not work with ACPI even though the
> > drivers are loaded.
> 
> Do you see irqs for USB if you boot with acpi?
> 
Everything's on IRQ 9. That's why sound is broken as well it seems - IRQ
sharing does not work as well as it should.

Regards,

Michel

