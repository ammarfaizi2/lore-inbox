Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbTJIU6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTJIU6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:58:18 -0400
Received: from madness.at ([213.153.61.104]:55560 "EHLO cronos.madness.at")
	by vger.kernel.org with ESMTP id S262557AbTJIU6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:58:17 -0400
Message-ID: <3F85CC0E.50003@madness.at>
Date: Thu, 09 Oct 2003 22:58:54 +0200
From: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6a) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Serverworks CSB5 IDE-DMA Problem (2.4 and 2.6)
References: <Pine.LNX.4.44.0310091634330.3040-100000@logos.cnet> <200310092146.17695.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310092146.17695.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> APIC problem should be fixed, but yes it's better to disable ACPI.

Not sure if I understand this one right - the dmesg was from the 
2.6.0-test6 kernel which did have ACPI HT-enum-only compiled in but no 
"local APIC support".
The 2.4.22 one that has the same problem does neither have ACPI nor APIC 
support compiled in - so no this doesn't seem to be the problem.

> These "timeout due to drive busy" needs to be resolved.

Yes - I really hope this will be fixed soon. I was forced to add a 
fiberchannel HBA into this maschine today to integrate it into our SAN 
to get the database up to speed again.
However I'm willing to move the database to the local disks again if you 
want me to test a patch or something along that line.



Stefan

