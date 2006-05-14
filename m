Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWENA4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWENA4m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 20:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWENA4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 20:56:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:8809 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932397AbWENA4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 20:56:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aODkjj5dypK5hSi6PZEP8ugajgy4CpcEP6ItYa2gfCvdvcjFS/ST1ZNt71Ikm/OqTV5NacoWkTWLNzLteNyznLoZTSXFf0F9MAME8tFxcJTgHykOhKfQP19OR1qo/tWcosVAA+E0HuWMetGYLSD8nSLC9F93rdAYW52sz3ZDpyk=
From: Patrick McFarland <diablod3@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Date: Sat, 13 May 2006 20:57:40 -0400
User-Agent: KMail/1.9.1
Cc: Peter Jones <pjones@redhat.com>, Martin Mares <mj@ucw.cz>,
       Jon Smirl <jonsmirl@gmail.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <1146778197.27727.26.camel@localhost.localdomain> <1147566572.21291.30.camel@localhost.localdomain>
In-Reply-To: <1147566572.21291.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605132057.42773.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 May 2006 20:29, Benjamin Herrenschmidt wrote:
> a long post.

So, why do we insist on keeping legacy hardware around? I mean, serial and 
parallel ports are basically dead, as are ps/2 ports (USB killed them all). 
VGA basically died out when DVI came around. Traditional IA32 is now dying 
out thanks to x86-64. The basic internals have been surplanted by APIC. We 
have a power management API, ACPI, which was unheard of on x86 15 years ago.

IDE is dying out, being replaced with SATA. Old SCSI methods are being 
replaced with Serial SCSI. I mean, I could basically go on for hours saying 
that pretty much all legacy hardware and methods are being replaced or have 
already been replaced.

Even the traditional IBM PC BIOS is being replaced, by various new firmware 
logic methods (such as openfirmware on x86, or intel's one who's name I 
forget.)

So, why do we continue keeping VGA around? Why isn't there a better method? 
Benjamin's post basically describes a technology that has been hacked to hell 
and back and has been around entirely too long, so why hasn't someone created 
something new?

-- 
Patrick McFarland || www.AdAstraPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

