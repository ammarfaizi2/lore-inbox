Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbUAZO3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 09:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUAZO3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 09:29:55 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:1219 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S263518AbUAZO3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 09:29:54 -0500
Date: Mon, 26 Jan 2004 15:29:16 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hugang <hugang@soulinfo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-ID: <20040126142916.GA965@bogon.ms20.nix>
References: <20040119105237.62a43f65@localhost> <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux> <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux> <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost> <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost> <1074912854.834.61.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074912854.834.61.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 01:54:15PM +1100, Benjamin Herrenschmidt wrote:
> Ok, I hammered that for a day and got pmdisk (patrick's version) suspending
> and resuming on a pismo G3 (with XFree etc.. running). Lots of rough edges
> still (via-pmu sleep need to be improved, ADB need porting to the new driver
> model to be properly suspended/resumed, a sysdev for RTC is needed too for
> time, the asm code should be fixed for G5, etc...)
Works fine on a 

processor       : 0
cpu             : 7455, altivec supported
clock           : 867MHz
revision        : 3.3 (pvr 8001 0303)
bogomips        : 863.00
machine         : PowerBook6,1
motherboard     : PowerBook6,1 MacRISC3 Power Macintosh
board revision  : 00000001
detected as     : 287 (PowerBook G4 12")
pmac flags      : 0000000b
L2 cache        : 256K unified
memory          : 256MB
pmac-generation : NewWorld

Cheers,
 -- Guido
