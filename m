Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbTJIVJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbTJIVJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:09:27 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:52216 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262582AbTJIVJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:09:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
Subject: Re: Serverworks CSB5 IDE-DMA Problem (2.4 and 2.6)
Date: Thu, 9 Oct 2003 23:13:05 +0200
User-Agent: KMail/1.5.4
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310091634330.3040-100000@logos.cnet> <200310092146.17695.bzolnier@elka.pw.edu.pl> <3F85CC0E.50003@madness.at>
In-Reply-To: <3F85CC0E.50003@madness.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310092313.05371.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 of October 2003 22:58, Stefan Kaltenbrunner wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > APIC problem should be fixed, but yes it's better to disable ACPI.
>
> Not sure if I understand this one right - the dmesg was from the
> 2.6.0-test6 kernel which did have ACPI HT-enum-only compiled in but no
> "local APIC support".
> The 2.4.22 one that has the same problem does neither have ACPI nor APIC
> support compiled in - so no this doesn't seem to be the problem.

Okay.

> > These "timeout due to drive busy" needs to be resolved.
>
> Yes - I really hope this will be fixed soon. I was forced to add a
> fiberchannel HBA into this maschine today to integrate it into our SAN
> to get the database up to speed again.
> However I'm willing to move the database to the local disks again if you
> want me to test a patch or something along that line.

Did some kernel worked okay or this is new system?

--bartlomiej

