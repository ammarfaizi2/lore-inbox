Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTJ1Wn6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTJ1Wn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:43:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:61377 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261754AbTJ1Wn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:43:56 -0500
Date: Tue, 28 Oct 2003 14:41:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jakub Krajcovic <news.receive@zoznam.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Floppy in 2.6
Message-Id: <20031028144127.0d0e89cd.rddunlap@osdl.org>
In-Reply-To: <20031028232054.1d452baa.news.receive@zoznam.sk>
References: <20031028232054.1d452baa.news.receive@zoznam.sk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 23:20:54 +0100 Jakub Krajcovic <news.receive@zoznam.sk> wrote:

| Hi everybody, this might be a stupid question, but here goes anyway:
| 
| I've been using the 2.6 test kernels from when -test4 was released, but only today have i noticed that my floppy drive is nowhere to be found.
| 
| I've checked the in the menu for the kernel config (make menuconfig) and i did not find the  "block devices > normal floppy support" option (as it was called in the 2.4 kernels) anywhere, and there is no /dev/fd0 on my system.

It's the first item listed under Block devices: Normal floppy disk support

It won't be listed for PC9800 or S/390 hardware.

| In 2.4 there was the option for "normal floppy support" and I have the /dev/fd0 device for my floppy when I boot the old 2.4.22 kernel. So my question is: does the 2.6 kernel support normal floppy disks or not? And if it does, how do I enable this support in order to use my floppy drive.

Yes.  What kind of system hardware?
Check for "CONFIG_BLK_DEV_FD" in the .config file.

--
~Randy
