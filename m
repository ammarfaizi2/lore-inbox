Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132399AbRDMX0w>; Fri, 13 Apr 2001 19:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132407AbRDMX0m>; Fri, 13 Apr 2001 19:26:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1551 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132399AbRDMX0d>; Fri, 13 Apr 2001 19:26:33 -0400
Subject: Re: New SYM53C8XX driver in 2.4.3-ac5 FIXES CD Writing!!!!
To: grantma@anathoth.gen.nz (Matthew Grant)
Date: Sat, 14 Apr 2001 00:28:05 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E14oCrt-0002ga-00@zion.int.anathoth.gen.nz> from "Matthew Grant" at Apr 14, 2001 11:20:44 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14oCz2-0003nA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel is more broken than beta7  version, a lot of lvm operations in the 
> kernel version DON'T WORK!!!

beta7 is also broken

> What are the problems????

Disgusting stuff like using the low 2bits of an address as flags.

> Reiserfs quota support should be added to the kernel if it is simple also.  

its not worth doing. Thats based on the current, racey, broken quota code
not the -ac quota code we need

> there rather than having a lot of different ongoing backroom operations to add 
> the functionality.

For the base kernel they need to work properly. Vendors may be less picky.
