Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270395AbTGNLyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270400AbTGNLyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:54:38 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28940 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S270395AbTGNLyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:54:35 -0400
Date: Mon, 14 Jul 2003 14:09:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Frank Elsner <Elsner@zrz.TU-Berlin.DE>
cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-2.6.0-test1] make xconfig fails 
In-Reply-To: <E19c1tZ-00070Q-JU@bronto.zrz.TU-Berlin.DE>
Message-ID: <Pine.LNX.4.44.0307141403120.717-100000@serv>
References: <E19c1tZ-00070Q-JU@bronto.zrz.TU-Berlin.DE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Jul 2003, Frank Elsner wrote:

> > > /usr/lib/qt3-gcc2.96/bin/moc -i scripts/kconfig/qconf.h -o scripts/kconfig/qconf
> > 
> > Which version is the g++ compiler?
> # g++ -v
> Reading specs from /usr/local/gcc-2.95.3/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/specs
> gcc version 2.95.3 20010315 (release)

Your QT seems to be compiled with 2.96 and both versions must match.
You can select a different c++ compiler with "make xconfig HOSTCXX=..." or 
a different QT version with "make xconfig QTDIR=...". If you don't have a 
matching pair, you have to recompile QT.

bye, Roman

