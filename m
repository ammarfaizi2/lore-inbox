Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131124AbRCGRYO>; Wed, 7 Mar 2001 12:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131080AbRCGRYE>; Wed, 7 Mar 2001 12:24:04 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1799 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131124AbRCGRXt>; Wed, 7 Mar 2001 12:23:49 -0500
Subject: Re: :Redhat [Bug 30944] - Kernel 2.4.0 and Kernel 2.2.18: with some programs
To: andreas.helke@lionbioscience.com (Andreas Helke)
Date: Wed, 7 Mar 2001 17:26:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, nfs@sourceforge.net,
        sg_info@lionbioscience.com, kirschh@lionbioscienc.com
In-Reply-To: <3AA63A2D.F723FA61@lionbioscience.com> from "Andreas Helke" at Mar 07, 2001 02:39:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ahiC-0001JG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately the missing files in directory listings from SGI Irix
> 6.5.9f NFS servers still persists with the  2.4 kernel - we used the
> kernel 2.4.0 kernel that came with the Redhat 7.1beta
> uname -a tells Linux test-ah1 2.4.0-0.99.11 #1 Wed Jan 24 16:07:17 EST
> 2001 i686 unknown

That is something I'd expect. I don't plan to merge the NFS changes into -ac
just yet. There are simply too many other things in 2.4 more important than
an Irix corner case right now.

Irix at least used to have an export option to do mappings to keep clients that
had 32/64bit inode problems happy. Do those help ?


