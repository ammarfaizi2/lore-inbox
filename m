Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSDXNJD>; Wed, 24 Apr 2002 09:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312119AbSDXNJC>; Wed, 24 Apr 2002 09:09:02 -0400
Received: from mustard.heime.net ([194.234.65.222]:47783 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S292730AbSDXNJB>; Wed, 24 Apr 2002 09:09:01 -0400
Date: Wed, 24 Apr 2002 15:09:00 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: Tigran Aivazian <tigran@aivazian.name>
cc: linux-kernel@vger.kernel.org
Subject: [REPOST3][BUG] RAMFS broken RDONLY in 2.4.19-pre7(-ac2)?
In-Reply-To: <Pine.LNX.4.33.0204241301240.3767-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.44.0204241507200.9134-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Tigran Aivazian wrote:

> On Wed, 24 Apr 2002, Roy Sigurd Karlsbakk wrote:
> > Too much mess.
> >
> > Of course, the /proc/devices was from my computer, compiled without proper
> > ramfs support. I don't have /proc/devices from the other one, as I can't
> > boot it, lacking RAMFS support.
> 
> actually, even more mess than you think, namely what you keep calling
> RAMFS (and ramfs) has nothing to do with ramfs. The ramfs is not needed to
> use ramdisk block devices. See CONFIG_RAMFS for more info.
> 
> Btw, there is also tmpfs but that has nothing to do with it either :)
> 

ok - false alarm. My specified size wasn't supported. After trying with 
32768 it worked.

But - the client couldn't write to / !!!

Is this correct?

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

