Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136437AbREGRfb>; Mon, 7 May 2001 13:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136454AbREGRfW>; Mon, 7 May 2001 13:35:22 -0400
Received: from rumor.cps.intel.com ([192.102.198.242]:51915 "EHLO
	rumor.cps.intel.com") by vger.kernel.org with ESMTP
	id <S136437AbREGRfG>; Mon, 7 May 2001 13:35:06 -0400
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE26F@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian Gerst <bgerst@didntduck.org>,
        linux-kernel@vger.kernel.org
Subject: RE: [PATCH] x86 page fault handler not interrupt safe 
Date: Mon, 7 May 2001 10:32:03 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Woodhouse [mailto:dwmw2@infradead.org]
> 
> torvalds@transmeta.com said:
> >  If anybody has such a beast, please try this kernel patch _and_
> > running the F0 0F bug-producing program (search for it on the 'net -
> > it must be out there somewhere) to verify that the code still
> > correctly handles that case. 
> 
> Something along the lines of:
> 
> echo "unsigned long main=0xf00fc7c8;" > f00fbug.c ; make f00fbug

Yes, that's what the (SGI) program uses:
http://lwn.net/2001/0329/a/ltp-f00f.php3

~Randy

