Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316025AbSETN7V>; Mon, 20 May 2002 09:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316027AbSETN7U>; Mon, 20 May 2002 09:59:20 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:54684 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP
	id <S316025AbSETN7T>; Mon, 20 May 2002 09:59:19 -0400
Date: Thu, 16 May 2002 16:36:55 +0200
From: Marc Lehmann <pcg@goof.com>
To: hgs@anna-strasse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE *data corruption* VIA VT8367
Message-ID: <20020516143655.GB13762@schmorp.de>
Mail-Followup-To: hgs@anna-strasse.de, linux-kernel@vger.kernel.org
In-Reply-To: <379487051.20020514195533@anna-strasse.de> <E177lx4-0000e6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux version 2.4.19-pre2-ac3 (root@fuji) (gcc version 2.95.4 20010319 (prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 12:43:30AM +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Has anybody seen this before? Any info would be appreciated. I would
> > be happy to provide more information.
> 
> I have multiple similar reports, and in all cases where people tried, switching
> to a non via chipset cured it - it might be co-incidence but I have enough
> reports I suspect its some kind of hardware incompatibility/limit with
> the VIA and multiple promise ide controllers

On my system (ASUS CUV4X-D + 2x promise tx2), disabling pci delayed
transactions completely cured the data corruption (which corrupted a few
hundred bytes every gigabyte or so, which is "massive"). Does this help in
this case, too?

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |

