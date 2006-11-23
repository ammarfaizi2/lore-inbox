Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933836AbWKWPms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933836AbWKWPms (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933835AbWKWPms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:42:48 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:31921 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S933832AbWKWPmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:42:47 -0500
Date: Thu, 23 Nov 2006 16:43:04 +0100
From: DervishD <lkml@dervishd.net>
To: The Peach <smartart@tiscali.it>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: bug? VFAT copy problem
Message-ID: <20061123154304.GC26900@DervishD>
Mail-Followup-To: The Peach <smartart@tiscali.it>,
	Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org
References: <20061120164209.04417252@localhost> <877ixqhvlw.fsf@duaron.myhome.or.jp> <20061120184912.5e1b1cac@localhost> <87mz6kajks.fsf@duaron.myhome.or.jp> <1164204175.10427.1.camel@localhost.localdomain> <20061122145344.GB18141@DervishD> <1164243385.3525.19.camel@monteirov> <20061123091301.GC21908@DervishD> <20061123122611.60a8fd7c@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061123122611.60a8fd7c@localhost>
User-Agent: Mutt/1.4.2.2i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Matteo :)

 * The Peach <smartart@tiscali.it> dixit:
> DervishD <lkml@dervishd.net> wrote:
> 
> > > Have you a solution for the case ? Now I have the file in ext3
> > > and I couldn't copy to any vfat :)
> > 
> >     No, I don't have any idea about how to do it, sorry :(
> > 
> 
> maybe using ntfs-3g driver with fuse or use the extX windows driver
> (if the need was read from Windows). I'm feeling quite confortable
> with the first solution, whilst the second is suggested by the
> official linux ntfs support page

    Of course, such options exist, but Sergio was asking to write to
a FAT-32, so... Myself, I use ext2 for my external disks if I can,
and I install the ext2-ifs driver for windows to read them. It works
like a charm.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
