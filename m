Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTLDREa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 12:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTLDREa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 12:04:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:3540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263130AbTLDRE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 12:04:26 -0500
Date: Thu, 4 Dec 2003 08:57:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Duncan Sands <baldrick@free.fr>
Cc: fuzzy77@free.fr, mfedyk@matchmail.com, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Message-Id: <20031204085704.12d398df.rddunlap@osdl.org>
In-Reply-To: <200312041214.33376.baldrick@free.fr>
References: <3FC4E8C8.4070902@free.fr>
	<20031203201149.42f58e2a.rddunlap@osdl.org>
	<3FCF1381.7090507@free.fr>
	<200312041214.33376.baldrick@free.fr>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003 12:14:33 +0100 Duncan Sands <baldrick@free.fr> wrote:

| > EIP is at releaseintf+0x62/0x80 [usbcore]
| 
| I haven't found time to work on this, sorry -
| I'm really busy with my real jobs right now.
| 
| > <0>Fatal exception: panic in 5 seconds
| 
| What is this, by the way?  I never saw it.

That comes from setting the sysctl "panic_on_oops" so that an oops
goes straight to a panic condition.

--
~Randy
MOTD:  Always include version info.
