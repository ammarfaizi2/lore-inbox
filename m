Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272316AbRHXUYL>; Fri, 24 Aug 2001 16:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272320AbRHXUYB>; Fri, 24 Aug 2001 16:24:01 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:23462 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S272316AbRHXUXm>;
	Fri, 24 Aug 2001 16:23:42 -0400
Date: Fri, 24 Aug 2001 22:23:50 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Daryll Strauss <daryll@valinux.com>
Cc: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: software raid does not do parallel reads under 2.4?
Message-ID: <20010824222350.C12903@fuji.laendle>
Mail-Followup-To: Daryll Strauss <daryll@valinux.com>,
	Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010823234218.B12873@cerebro.laendle> <15238.11161.492557.264988@notabene.cse.unsw.edu.au> <3B868874.B89B04DE@gmx.at> <20010824101439.C1717@newbie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20010824101439.C1717@newbie>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 10:14:39AM -0700, Daryll Strauss <daryll@valinux.com> wrote:
> > There were a lot of ide reports some time ago. Maybe they where problems
> > with concurrent I/O operations...?
> 
> I'm seeing similar behavior with SCSI. I've got two SCSI channels. If I
> run two dd's each talking to disks on different channels, I get 2x disk

similar, but quite different: the difefrence is that i get full speed when
accessing drives as /dev/hdx, but slow speed when doping the same opertaion
using md.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
