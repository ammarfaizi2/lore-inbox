Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVEBPx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVEBPx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 11:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVEBPx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 11:53:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:42458 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261346AbVEBPxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 11:53:11 -0400
Date: Mon, 2 May 2005 08:49:30 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: bunk@stusta.de, tomlins@cam.org, zwane@arm.linux.org.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
Message-Id: <20050502084930.6914e152.rddunlap@osdl.org>
In-Reply-To: <200505021528.j42FS5QJ006515@turing-police.cc.vt.edu>
References: <20050429231653.32d2f091.akpm@osdl.org>
	<Pine.LNX.4.61.0504301700470.3559@montezuma.fsmlabs.com>
	<20050430161032.0f5ac973.rddunlap@osdl.org>
	<200505010909.38277.tomlins@cam.org>
	<20050501133040.GB3592@stusta.de>
	<200505021528.j42FS5QJ006515@turing-police.cc.vt.edu>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 May 2005 11:28:05 -0400 Valdis.Kletnieks@vt.edu wrote:

| On Sun, 01 May 2005 15:30:40 +0200, Adrian Bunk said:
| 
| > How much bandwith does this require?
| > 
| > Currently, 2.6.12-rc3-mm1 requires 3.7 MB for the -rc3 patch (which can 
| > be used for several -mm patches) plus 2.6 MB for the -mm patch.
| > 
| > The 47 MB download for 2.6.11 are required only once for the many -mm 
| > kernels between 2.6.11 and 2.6.12.
| > 
| > Looking at these numbers, the average download required for every -mm 
| > kernel is currently far below 10 MB.
| 
| And even *more* importantly, note that when downloading a -mm or -rc3 patch,
| there's minimal server overhead - it opens *one* file and streams it to the
| FTP connection.  sendfile() anybody? ;)
| 
| How many open/close/etc are needed to sync up 2 'git' mirrors?  I don't care *how*
| stupendous git/mercurial/whatever are, they're going to have a *really* hard time
| getting down to the overhead of an FTP session sending a .bz2 file.
| 
| Unless of course, there's only me and a dozen other people even *trying* -mm
| kernels and the distinction is lost in the noise... (Out of curiosity, how
| many downloads *DO* the -mm kernels get?  I know Linus and Andrew want more
| testing.. let's keep that in mind here.. ;)

Last I heard, Andrew had access to kernel.org transfer logs,
but the problem is that we can't tell anything about the download
counts from mirrors.

---
~Randy
