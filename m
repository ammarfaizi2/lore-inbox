Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVDHTxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVDHTxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVDHTxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:53:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:42895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262940AbVDHTx0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:53:26 -0400
Date: Fri, 8 Apr 2005 12:49:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: pmarques@grupopie.com, linux-kernel@vger.kernel.org, yum.rayan@gmail.com
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
Message-Id: <20050408124955.6b36048e.rddunlap@osdl.org>
In-Reply-To: <20050408194355.GH15688@stusta.de>
References: <4252BC37.8030306@grupopie.com>
	<20050407214747.GD4325@stusta.de>
	<42567B3E.8010403@grupopie.com>
	<20050408130008.GA6653@stusta.de>
	<4256B04A.8070909@grupopie.com>
	<20050408194355.GH15688@stusta.de>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005 21:43:55 +0200 Adrian Bunk wrote:

| On Fri, Apr 08, 2005 at 05:24:42PM +0100, Paulo Marques wrote:
| > Adrian Bunk wrote:
| > >[...]
| > >>>On Tue, Apr 05, 2005 at 05:26:31PM +0100, Paulo Marques wrote:
| > >>
| > >>Hi Adrian,
| > >
| >...
| > >Joerg's list of recursions should be valid independent of the kernel 
| > >version. Fixing any real stack problems [1] that might be in this list 
| > >is a valuable task.
| > >
| > >And "make checkstack" in a kernel compiled with unit-at-a-time lists 
| > >several possible problems at the top.
| > 
| > Ok, I've read Jörn's mail also and I think I can help out. It seems 
| > however that there are more people working on this. Will it be better to 
| > coordinate so we don't duplicate efforts or is the "everyone looks at 
| > everything" approach better, so that its harder to miss something?
| 
| The only other person that seemed very interested n stack issues was
| Yum Rayan <yum.rayan@gmail.com>.

Well, I am, but they are not high on my list right now,
so no coordination is needed with me currently.

| You could coordinate with him, but in the end it should be possible to 
| have a first set of patches ready a few hours or even minutes after you 
| started, so duplicate efforts would require a very unlucky timing.
| 
| > Paulo Marques
| 
| cu
| Adrian

---
~Randy
