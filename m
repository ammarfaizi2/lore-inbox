Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270317AbTGNLdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270364AbTGNLdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:33:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:24076 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S270317AbTGNLdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:33:50 -0400
Date: Mon, 14 Jul 2003 13:48:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Elsner@zrz.TU-Berlin.DE, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-2.6.0-test1] make xconfig fails
In-Reply-To: <E19c0nd-0006L9-4m@bronto.zrz.TU-Berlin.DE>
Message-ID: <Pine.LNX.4.44.0307141325170.717-100000@serv>
References: <E19c0nd-0006L9-4m@bronto.zrz.TU-Berlin.DE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Jul 2003, Frank Elsner wrote:

> RHL 7.3, gcc-2.95.3, copied .config from 2.4.21 source tree 
>                                       to linux-2.6.0-test1 source tree.
> make oldconfig went ok.
> 
> Later make xconfig failed:

It's most likely a mismatch between QT and g++.
Older RedHat systems have that problem, although most of the time it 
already fails at linking.

> /usr/lib/qt3-gcc2.96/bin/moc -i scripts/kconfig/qconf.h -o scripts/kconfig/qconf

Which version is the g++ compiler?

bye, Roman

