Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265358AbTFML3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 07:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTFML3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 07:29:40 -0400
Received: from gandalf.sch.bme.hu ([152.66.212.141]:61842 "EHLO
	gandalf.sch.bme.hu") by vger.kernel.org with ESMTP id S265358AbTFML3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 07:29:40 -0400
Date: Fri, 13 Jun 2003 13:43:24 +0200
From: Zsolt Babak <zod@sch.bme.hu>
To: Kevin Fenzi <kevin@scrye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc8-laptop1 released
Message-ID: <20030613114324.GA24705@gandalf.sch.bme.hu>
References: <20030612223940.7fcc00a1.hanno@gmx.de> <20030612211707.2266BF7FE0@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20030612211707.2266BF7FE0@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This has nothing to do with the laptop patch, these defines are really
missing from include/linux/pci_ids.h. 

In -rc5 I just removed the line from the .c file that referenced the
missing ID, and it works very well...  

Maybe this is a bug ;)

    Zod.

On Thu, Jun 12, 2003 at 03:17:02PM -0600, Kevin Fenzi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Hanno> The second release of laptopkernel is out.  Get it at
> Hanno> https://savannah.nongnu.org/projects/laptopkernel/
> Hanno> 2.4.21-rc8-laptop1
> 
> Humm... doesn't seem to compile here...
> 
> am I missing something?
> 
> make[5]: Entering directory `/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/drivers/char/agp'
> gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=pentium4 -g  -nostdinc -iwithprefix include -DKBUILD_BASENAME=agpgart_fe  -c -o agpgart_fe.o agpgart_fe.c
<snip>

