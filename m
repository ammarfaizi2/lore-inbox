Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUBKOxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUBKOxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:53:22 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:19654 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263088AbUBKOxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:53:18 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andi Kleen <ak@suse.de>
Subject: Re: kgdb support in vanilla 2.6.2
Date: Wed, 11 Feb 2004 20:22:38 +0530
User-Agent: KMail/1.5
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com, trini@kernel.crashing.org, george@mvista.com
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <200402061835.16960.amitkale@emsyssoft.com> <20040206142441.23def5f3.ak@suse.de>
In-Reply-To: <20040206142441.23def5f3.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402112022.38037.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 Feb 2004 6:54 pm, Andi Kleen wrote:
> > > > > > > What I found always extremly ugly in the i386 stub was that it
> > > > > > > uses magic globals to talk to the page fault handler. For the
> > > > > > > x86-64 version I replaced that by just using __get/__put_user
> > > > > > > in the memory accesses, which is much cleaner. I would suggest
> > > > > > > doing that for i386 too.

Done in this version of kgdb.

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

