Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314471AbSECPxD>; Fri, 3 May 2002 11:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314472AbSECPxC>; Fri, 3 May 2002 11:53:02 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:4224 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S314471AbSECPxB>; Fri, 3 May 2002 11:53:01 -0400
Date: Fri, 3 May 2002 08:53:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Krzysiek Taraszka <dzimi@ep09.kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC and 2.2.21rc3 with modular ide subsystem
Message-ID: <20020503155313.GA894@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.44.0205031339430.24354-100000@ep09.kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 01:58:49PM +0200, Krzysiek Taraszka wrote:

> I tried compile 2.2.21rc3 with modular ide subsystem and i got that 
> messages:

Pmac IDE is not able to be built as a module.  If you just have a PCI
IDE card you want to use, you should be able to if you set
CONFIG_BLK_DEV_IDE_PMAC to n.  Otherwise you must compile it in.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
