Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267949AbUHPUmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267949AbUHPUmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUHPUmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:42:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:47244 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267949AbUHPUmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:42:37 -0400
Date: Mon, 16 Aug 2004 22:39:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@fs.tum.de>
cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER ->
 depends HOTPLUG]
In-Reply-To: <20040816202253.GC1387@fs.tum.de>
Message-ID: <Pine.LNX.4.61.0408162236370.12756@scrub.home>
References: <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org>
 <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org>
 <20040814210523.GG1387@fs.tum.de> <Pine.LNX.4.61.0408151932370.12687@scrub.home>
 <20040815174028.GM1387@fs.tum.de> <Pine.LNX.4.61.0408160043270.12687@scrub.home>
 <20040816195733.GZ1387@fs.tum.de> <20040816210729.A25893@flint.arm.linux.org.uk>
 <20040816202253.GC1387@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 16 Aug 2004, Adrian Bunk wrote:

> But it still leaves the problem that modules not included in the kernel  
> might require the functionality provided by such an option.
> Even CRC32 is user-visible.

config CRC32
	tristate "CRC32 functions" if SHOW_ME_EVERYTHING
	default m

bye, Roman
