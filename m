Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTIORA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 13:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTIORA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 13:00:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:39322 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261569AbTIORAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 13:00:24 -0400
Date: Mon, 15 Sep 2003 09:53:54 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: reg@dwf.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5: "No module aic7xxx found for kernel 2.6.0-test5, 
 aborting."
Message-Id: <20030915095354.6f28eedd.rddunlap@osdl.org>
In-Reply-To: <200309130725.h8D7PE6d019675@orion.dwf.com>
References: <200309130725.h8D7PE6d019675@orion.dwf.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Sep 2003 01:25:14 -0600 reg@dwf.com wrote:

| When trying to build SCSI support into 2.6.0-test5, 
| I configure SCSI, but
| whether I configure NO driver at all
| or configure the aic7xxx driver
| when I get to the 
|     make install
| I constantly get the error message  
|     No module aic7xxx found for kernel 2.6.0-test5, aborting.
| 
| Surely SOMEONE has built this kernel with SCSI support, 
| so why is it giving me this trouble.
| 
| I can probably build w/o ANY SCSI support at all, but that wouldnt be
| useful, so I havent tried...

I build and boot with aic7xxx built into vmlinux all the time.
However, I don't use 'make install' so I haven't seen this.
If noone else knows the answer to this problem, perhaps you could
debug install.sh or /sbin/installkernel (if those are being used).

--
~Randy
