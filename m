Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSFNVwG>; Fri, 14 Jun 2002 17:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSFNVwF>; Fri, 14 Jun 2002 17:52:05 -0400
Received: from dsl093-058-082.blt1.dsl.speakeasy.net ([66.93.58.82]:35572 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314485AbSFNVwE>; Fri, 14 Jun 2002 17:52:04 -0400
Date: Fri, 14 Jun 2002 17:52:04 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
X-X-Sender: <becker@presario>
To: Matthew Hall <matt@ecsc.co.uk>
cc: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
In-Reply-To: <1024070779.972.53.camel@smelly.dark.lan>
Message-ID: <Pine.LNX.4.33.0206141750480.1042-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jun 2002, Matthew Hall wrote:

> Sorry to bother you again Donald, but I'm still having problems,
> The following error comes up when I make modules with the 1.06 version:
>
> sundance.c: In function `sundance_probe1':
> sundance.c:464: `pci_tbl' undeclared (first use in this function)

The line before these said that 'pci-scan.h' couldn't be found.

  ftp://www.scyld.com/pub/network/pci-scan.h

Read
  http://www.scyld.com/network/updates.html

> I've checked the code of sundance.c, pci-scan.h and kern_compat.c and
> pci_tbl isn't defined or declared anywhere in these files, am I missing
> something else, or going crazy?

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

