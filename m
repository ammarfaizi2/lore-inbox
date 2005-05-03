Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVECOb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVECOb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVECObD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:31:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:30855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261686AbVECO0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:26:42 -0400
Date: Tue, 3 May 2005 07:26:26 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
Message-Id: <20050503072626.3a3c7349.rddunlap@osdl.org>
In-Reply-To: <20050503104503.GA11123@animx.eu.org>
References: <20050503012951.GA10459@animx.eu.org>
	<20050502193503.20e6ac6e.rddunlap@osdl.org>
	<20050503104503.GA11123@animx.eu.org>
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

On Tue, 3 May 2005 06:45:03 -0400 Wakko Warner wrote:

| Randy.Dunlap wrote:
| > On Mon, 2 May 2005 21:29:51 -0400 Wakko Warner wrote:
| > | Is it possible to use zImage on 2.6 kernels or is bzImage required?
| > 
| > What processor architecture?
| 
| x86.  Does zImage work on other arches?  (I've only ever dealt with alpha
| and sparc other than x86)

I don't know if it works, just that it's listed in:
ppc, arm, sh, cris, arm26, m68k, ppc64, parisc, m32r, frv,
and sh64.  and i386.

| > It's supported in arch/i386/Makefile (and some others).
| > For i386, you'll need to disable enough (lots of) options to make the
| > resulting output file small enough...
| 
| The resultant bzImage is ~760kb.  I compiled out everything I could, only
| ram disk/initrd, and ext2 are compiled in.
| 
| If you'd like to see the .config, I'll send it up.

Are you saying that zImage still fails (image is too large?) ?

I built one, but I wouldn't want to boot it.  :)
It looks like you would need to put almost everything into
an initrd to make it usable.

---
~Randy
