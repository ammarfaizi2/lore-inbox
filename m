Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbULABWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbULABWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbULABM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:12:27 -0500
Received: from canuck.infradead.org ([205.233.218.70]:37642 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261201AbULABGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:06:45 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0411301656051.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <8219.1101828816@redhat.com>
	 <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
	 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
	 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
	 <1101854061.4574.4.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org>
	 <1101858657.4574.33.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301605500.22796@ppc970.osdl.org>
	 <1101860688.4574.50.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301636050.22796@ppc970.osdl.org>
	 <1101862057.4574.67.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301656051.22796@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 01:06:17 +0000
Message-Id: <1101863177.4574.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 16:57 -0800, Linus Torvalds wrote:
> This isn't even a "fix". It's a cleanup. It goes under the same rules
> a spelling fix does.

So you don't see a long-term technical benefit in cleaning up the
API/ABI we export to userspace so that userspace stops depending on
stuff which just isn't supposed to be there? It's all just cosmetic
masturbation as far as you're concerned? There's no point in trying to
get to the point where we don't need to separately maintain a 
glibc-kernheaders package because it can be taken directly from the
kernel?

-- 
dwmw2

