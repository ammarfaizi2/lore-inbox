Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUDCBFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 20:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUDCBFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 20:05:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:36509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261474AbUDCBFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 20:05:32 -0500
Date: Fri, 2 Apr 2004 17:02:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange output from exportfs in 2.6.5-rc3-mm1
Message-Id: <20040402170207.17d5dabc.rddunlap@osdl.org>
In-Reply-To: <20040331220744.5fc69f2d.akpm@osdl.org>
References: <20040331030439.GA23306@outblaze.com>
	<20040331144031.360c2c3f.rddunlap@osdl.org>
	<20040331213902.147036f3.akpm@osdl.org>
	<20040331214417.41ea2635.rddunlap@osdl.org>
	<20040331220744.5fc69f2d.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004 22:07:44 -0800 Andrew Morton wrote:

| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| >
| > | You probably didn't have modversions enabled?
| > 
| >  Not the first time; I did the second time, but when I booted,
| >  it rebooted for me during early init (repeatable).  :(
| >  (P4 2-proc)  Then I went home.  I can look into this more
| >  tomorrow... or is this a known issue?
| 
| Not a known issue.  I can take a look if you want to send the .config.
| 
| (Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)


2.6.5-mm[134] all reset for me during early boot... if I have ACPI
enabled.  -mm3 boots fine with ACPI disabled.

This is on an IBM P4 XEON 2-proc (1.7 GHz) system.
I added some early printk's during start_kernel() but I could
never see them.

Len, what do you need on this?

--
~Randy
"We have met the enemy and he is us."  -- Pogo (by Walt Kelly)
