Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316228AbSEKPAb>; Sat, 11 May 2002 11:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316229AbSEKPAa>; Sat, 11 May 2002 11:00:30 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:61189 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316228AbSEKPAa>; Sat, 11 May 2002 11:00:30 -0400
Date: Sat, 11 May 2002 17:00:26 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.14-dj2
Message-ID: <20020511150026.GA6910@louise.pinerecords.com>
In-Reply-To: <20020508225147.GA11390@suse.de> <4.1.20020511114723.009c8270@pop.cablewanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 17:11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> found a few other problems:
> 1) the pio fix posted last week is not included in your tree or Linus' and
> I found this the hard way: severe filesystem damage and system lockup and a
> kernel (2.4.19-pre8) panic because the root partition could not be mounted
> (as reported before). 

patch-2.5.14, lines 11813, 11814:
-                       ata_write_16(drive, buffer, wcount<<1);
+                       ata_write_16(drive, buffer, wcount);

t.
