Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272582AbTG1A2R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272607AbTG1A1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:27:05 -0400
Received: from lidskialf.net ([62.3.233.115]:23759 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S272590AbTG1AZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 20:25:32 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: PCI trouble with 2.6.0-test2
Date: Mon, 28 Jul 2003 01:40:48 +0100
User-Agent: KMail/1.5.2
References: <20030727221610.GA763@nevyn.them.org> <20030728001132.GA827@nevyn.them.org>
In-Reply-To: <20030728001132.GA827@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307280140.48939.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 01:11, Daniel Jacobowitz wrote:
> On Sun, Jul 27, 2003 at 06:16:10PM -0400, Daniel Jacobowitz wrote:
> > I can't say offhand what the last 2.5.x kernel to boot on this system
> > was; it's been a while since I tried.  2.6.0-test2 definitely doesn't
> > though. The machine is a dual-Pentium3 using an Abit motherboard; nothing
> > else particularly fancy.
> >
> > Thanks to the wonders of serial console, here's the interesting parts of
> > the boot log:
>
> With ACPI disabled at the command line, it does boot, although the
> aty128fb error is still there - and is making X have bizarre
> striping.  I've attached logs with ACPI on and off in (with PCI
> debugging on) in the hopes that someone has an idea.  Nothing jumps out
> at me.

Hi, if you can send me your /proc/acpi/dsdt, I might be able to help. 

As your machine doesn't boot in ACPI, I can see this might be a problem. Maybe 
setting "CPU Enumeration only" in the ACPI config will let it boot?

If not, grab a copy of http://people.freebsd.org/~takawata/pacpidump.tar.gz
It can extract it without the need to have ACPI enabled.

