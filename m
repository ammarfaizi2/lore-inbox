Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTJ2QUB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 11:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTJ2QUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 11:20:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:55513 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262086AbTJ2QUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 11:20:00 -0500
Date: Wed, 29 Oct 2003 08:17:16 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Konstantin Kletschke <konsti@ludenkalle.de>
Cc: news.receive@zoznam.sk, linux-kernel@vger.kernel.org
Subject: Re: Floppy in 2.6
Message-Id: <20031029081716.0352584b.rddunlap@osdl.org>
In-Reply-To: <20031029084212.GA4001%konsti@ludenkalle.de>
References: <20031028232054.1d452baa.news.receive@zoznam.sk>
	<20031029084212.GA4001%konsti@ludenkalle.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003 09:42:12 +0100 Konstantin Kletschke <konsti@ludenkalle.de> wrote:

| * Jakub Krajcovic <news.receive@zoznam.sk> [Tue, Oct 28, 2003 at 11:20:54PM +0100]:
| > 
| > I've been using the 2.6 test kernels from when  -test4  was  released,
| > but only today have i noticed that my floppy drive is  nowhere  to  be
| > found.
| 
| Enable ISA-Bus Support. Then, as the others point out, first item in
| Block Devices.

Seems like there was a time when CONFIG_ISA was required.
Ah yes, reverted on Oct. 9, 2003.
In 2.6.0-test9, BLK_DEV_FD does not depend on ISA at all.

--
~Randy
