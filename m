Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283428AbRLDUmL>; Tue, 4 Dec 2001 15:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283376AbRLDUkp>; Tue, 4 Dec 2001 15:40:45 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:43433
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S283379AbRLDUjj>; Tue, 4 Dec 2001 15:39:39 -0500
Date: Tue, 4 Dec 2001 13:39:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavlov Peter <Peter_Pavlov@BetaResearch.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error by make zImage
Message-ID: <20011204203936.GW17651@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <6BC16425F21921409CFE741208B1440337AC92@GAUGUIN.betaresearch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 05:39:14PM +0100, Pavlov Peter wrote:

> 
> trying to compile the linux-2.4.16 with this config
>  <<conf>> 
> I've got this errors. 
> I hope that will help you to find some bugs

1) CONFIG_NVRAM on PPC is powermac-specific, turn that off
2) The 8xx i2c code isn't yet in the kernel.org tree, turn that off

You'll probably have much better luck with one of the PPC trees, at
http://penguinppc.org/dev/kernel.shtml

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
