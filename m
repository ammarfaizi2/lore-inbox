Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVCNIjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVCNIjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVCNIjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:39:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49818 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261649AbVCNIjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:39:01 -0500
Date: Mon, 14 Mar 2005 09:37:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Lang <david.lang@digitalinsight.com>
Cc: Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: dmesg verbosity [was Re: AGP bogosities]
Message-ID: <20050314083717.GA19337@elf.ucw.cz>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org> <87vf7xg72s.fsf@devron.myhome.or.jp> <20050311222614.GH4185@redhat.com> <20050314081721.GA13817@elf.ucw.cz> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I'm fascinated that not a single person picked up on this problem
> >>whilst the agp code sat in -mm. Even if DRI isn't enabled,
> >>every box out there with AGP that uses the generic routines
> >>(which is a majority), should have barfed loudly when it hit
> >>this check during boot.  Does no-one read dmesg output any more ?
> >
> >Its way too long these days. Like "so long it overflows even enlarged
> >buffer". We should prune these messages down to "one line per hw
> >device or serious problems only".
> 
> especially if you turn on encryption options. I can understand that output 
> being useful for debugging, but there should be a way to not deal with it 
> in the normal case.

Perhaps we could have a rule like

"non-experimental driver may only print out one line per actual
device?"

(and perhaps: dmesg output for boot going okay should fit on one screen).

Or perhaps we should have warnings-like regression testing.

"New kernel 2.8.17 came: 3 errors, 135 warnings, 1890 lines of dmesg
junk".
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
