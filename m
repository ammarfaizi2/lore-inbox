Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWFUNJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWFUNJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWFUNJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:09:14 -0400
Received: from s233-64-196-242.try.wideopenwest.com ([64.233.242.196]:35528
	"EHLO echohome.org") by vger.kernel.org with ESMTP id S1751561AbWFUNJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:09:12 -0400
Message-ID: <23064.216.68.248.2.1150895349.squirrel@www.echohome.org>
In-Reply-To: <1150887073.15275.34.camel@localhost.localdomain>
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAMbmKIDqIQhHt6BBy4E2zd0BAAAAAA==@EchoHome.org>
    <1150887073.15275.34.camel@localhost.localdomain>
Date: Wed, 21 Jun 2006 09:09:09 -0400 (EDT)
Subject: RE: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver 
     for PDC202XX
From: "Erik Ohrnberger" <Erik@echohome.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: erik@echohome.org, linux-kernel@vger.kernel.org
Reply-To: Erik@echohome.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, June 21, 2006 06:51, Alan Cox wrote:
> Ar Maw, 2006-06-20 am 21:19 -0400, ysgrifennodd Erik Ohrnberger:
>> Downloaded kernel code.
>> Applied the IDE patches (http://zeniv.linux.org.uk/~alan/IDE)
>> 	(had to apply the change from ata_data_xfer calls to ops->data_xfer
>> 	(no big deal, I speak C )
>
> What tree are you working against. The patches I put up are versus
> 2.6.17 not -mm. Also check in include/linux/libata.h that
> ATA_ENABLE_PATA is defined (its down with the debug options). The patch
> should have enabled it however.
>
I downloaded linux-2.6.17.tar.gz from kernel.org, when extraceted created
linux-2.6.17 directory.  I zmore'd the patch-2.6.17-rc4-ide1.gz file and
noticed that it was working against linux-2.6.17-rc4-ide1, so I renamed
the linux-2.6.17 to linux-2.6.17-rc4-ide1 and zcat | patch -p0.
(Did I do this wrong?  Seemed to apply except for the two function calls
that I had to edit by hand)

Checking include/linux/libata.h reveals that: ATA_ENABLE_PATA is defined.

Thanks for all the help.  I really appreciate it, but hope that it's not
taking up too much of your time.

     Erik.

