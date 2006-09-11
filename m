Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWIKOKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWIKOKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 10:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWIKOKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 10:10:25 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:33469 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750776AbWIKOKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 10:10:24 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: x60 - spontaneous thermal shutdown
Date: Mon, 11 Sep 2006 16:10:36 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <linux-acpi@vger.kernel.org>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060904214059.GA1702@elf.ucw.cz> <20060911094607.GA14095@suse.de>
In-Reply-To: <20060911094607.GA14095@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111610.37514.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 11 September 2006 11:46, Stefan Seyfried wrote:
> On Mon, Sep 04, 2006 at 11:40:59PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > x60 shut down after quite a while of uptime, in period of quite heavy
> > load:
> > 
> > Sep  4 23:33:01 amd kernel: ACPI: Critical trip point
> > Sep  4 23:33:01 amd kernel: Critical temperature reached (128 C), shutting down.
> > Sep  4 23:33:01 amd shutdown[32585]: shutting down for system halt
> > Sep  4 23:34:42 amd init: Switching to runlevel: 0
> > 
> > I do not think cpu reached 128C, as I still have my machine... Did
> > anyone else see that?
> 
> my usual suspect: use ec_intr=0.

Is this a kernel command line parameter?

I'm having some suspend/resume related problems on HPC 6325 now, and they
seem to be related to the embedded controller.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
