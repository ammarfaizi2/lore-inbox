Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTKEAX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 19:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKEAX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 19:23:56 -0500
Received: from mrout2.yahoo.com ([216.145.54.172]:41227 "EHLO mrout2.yahoo.com")
	by vger.kernel.org with ESMTP id S262572AbTKEAXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 19:23:55 -0500
Message-ID: <3FA842D1.4090502@bigfoot.com>
Date: Tue, 04 Nov 2003 16:22:41 -0800
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, Ben Collins <bcollins@debian.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.0-test9 SATA and 1394 problems
References: <5.2.0.9.0.20031104234330.02451b70@mailhost.ivimey.org>
In-Reply-To: <5.2.0.9.0.20031104234330.02451b70@mailhost.ivimey.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:
> Folks,
> 
> I have been running 2.6.0-t9 on an Asus A7V600 VIA VT600-based MB for a 
> few days now. All seems relatively stable, which is good. A few issues 
> to report, though, the most serious of which is that my SATA controller 
> (VIA 8237 Southbridge) is only detected properly when the machine is 
> fully power-cycled (that is, plug out the back, not just soft-off). When 
> that is done, all seems well and the drives run fine. If you reboot the 
> machine without a full power-cycle, the SATA controller is detected but 
> no drives are found. Drives are new Seagate 7200.7 SATA 120Gig. I've 
> tried disabling acpi, setting pci=noacpi and setting pci=usepirqmask as 
> suggested in the acpi startup messages, but none of this helped.

   I have similar problem with intel D865PERL motherboard. only it 
happens rarely. It seems that _sometime_ when I restart system the BIOS 
does not recognize SATA drives (it waits for a fairly long time), linux 
then does not recognize SATA drives either.

   it doesn't seem to be linux specific (IIRC it happened when rebooting 
win xp pro as well).

	erik

