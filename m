Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbTLERrs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbTLERrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:47:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48571 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264359AbTLERrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:47:46 -0500
Message-ID: <3FD0C4B0.8020106@pobox.com>
Date: Fri, 05 Dec 2003 12:47:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mickael Marchand <marchand@kde.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <20031204081732.GC5376@launay.org> <3FCF4C32.5040101@pobox.com> <200312051842.26599.marchand@kde.org>
In-Reply-To: <200312051842.26599.marchand@kde.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mickael Marchand wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> as I was too impatient, I wrote a quick hack for it.
> Now I can see my drives on the 3114 controller.
> RAID does not seem to work but I can access my SATA drives in normal mode.
> 
> hdparm gives a 57 Mb/s output.
> I had no error/crash/corruption, it appears to work correctly.
> 
> It works on 2.4.23 and 2.6.0-test11 with libata.
> basically, you just need to add the PCI id for 3114 just like 3112 in 
> sata_sil.c, load the module and enjoy.
> I presume 3112 and 3114 chips are mostly identical.
> 
> I have tested this on 2 Tyan motherboards with Sil 3114 inside
> 
> I can generate a patch in a few moments if you want it.


Yes, a tested patch would be great, thanks!

	Jeff



