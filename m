Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314728AbSDWFYq>; Tue, 23 Apr 2002 01:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314734AbSDWFYp>; Tue, 23 Apr 2002 01:24:45 -0400
Received: from [203.200.51.170] ([203.200.51.170]:20211 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314728AbSDWFYp>; Tue, 23 Apr 2002 01:24:45 -0400
Message-Id: <200204230536.g3N5aDI05630@localhost.localdomain>
Content-Type: text/plain;
  charset="iso-8859-1"
From: rpm <rajendra.mishra@timesys.com>
Reply-To: rajendra.mishra@timesys.com
Organization: Timesys
To: =?iso-8859-1?q?LiborVan=ECk?= <libor@conet.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: Adding snapshot capability to Linux
Date: Tue, 23 Apr 2002 11:06:05 +0530
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3CC3ECD2.9000205@conet.cz> <3CC3FCD2.2030008@loewe-komp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 April 2002 05:36 pm, Peter Wächtler wrote:
> Libor Vanìk wrote:
> > Hi,
> > I'm going to start my dissertation work which is "Adding snapshop
> > capability to Linux kernel with copy-on-write support". My idea is add
> > it as another VFS - I know that there is some snapshot support in LVM
> > but it's working on "device-level" and I'd like/have to do it on fs
> > level.
> 


Instead of changing VFS you can probably make a generic stackable FS module 
.....that can stack on top of the physical filesystems  and happily take 
snapshots at "FS" level :) ! and you can use the FIST to create a basic 
stackable FS and then modify it to take care of snapshoting ! ( the good part 
is it can work on scores of other OSs like solaris , freeBSD etc ) 
i created one for ext2 but then it was not genric enough to work for other FS 
! 

cheers,
rpm


