Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268380AbTGIPcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 11:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268384AbTGIPcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 11:32:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268380AbTGIPcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 11:32:08 -0400
Date: Wed, 9 Jul 2003 08:45:15 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: sitsofe@lycos.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops running video capture software
Message-Id: <20030709084515.2cdb24ca.rddunlap@osdl.org>
In-Reply-To: <AGAKACEMILICLBAA@mailcity.com>
References: <AGAKACEMILICLBAA@mailcity.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jul 2003 10:21:42  0000 "Sitsofe Wheeler" <sitsofe@lycos.com> wrote:

| While running video capture software, the kernel will eventually oops in kswapd. There do seem to be some different kernels where it will take longer for this to happen (possibly those with apic support) but so far I haven't been able to isolate them. The oops will only happen while video capture is happening otherwise the system is extremely solid.
| 
| The kernel being used is 2.4.21 patched with preempt, low-latency, bootsplash and variable hz (the hz was set to 200).

You'll need to run that oops message thru ksymoops for it to be
useful.

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
