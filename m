Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262226AbSJATN0>; Tue, 1 Oct 2002 15:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbSJATNL>; Tue, 1 Oct 2002 15:13:11 -0400
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:14210 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S262128AbSJATMp>; Tue, 1 Oct 2002 15:12:45 -0400
Date: Tue, 1 Oct 2002 12:17:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC: more config dependency problems
Message-ID: <20021001191756.GA705@opus.bloom.county>
References: <Pine.GSO.4.44.0209270914210.6491-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0209270914210.6491-100000@math.ut.ee>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 09:19:54AM +0300, Meelis Roos wrote:

> This time I compiled some modular IDE to get usb-storage to work.
> Appears there are config dependency problems in IDE too - vmlinux
> doesn't link (2.4.20-pre8). This is just FYI, I can probably find a
> configuration that links.
[snip]
> CONFIG_BLK_DEV_IDE=m
[snip]
> CONFIG_BLK_DEV_IDE_PMAC=y

Yes, this is a known invalid configuration.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
