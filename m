Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbULNWCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbULNWCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbULNWCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:02:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:30424 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261688AbULNV61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:58:27 -0500
Date: Tue, 14 Dec 2004 13:58:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Werner Almesberger <wa@almesberger.net>
cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <20041214184605.B1271@almesberger.net>
Message-ID: <Pine.LNX.4.58.0412141351570.3279@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <20041214025110.A28617@almesberger.net>
 <Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org> <20041214135029.A1271@almesberger.net>
 <Pine.LNX.4.58.0412140950520.3279@ppc970.osdl.org> <20041214184605.B1271@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Werner Almesberger wrote:
> > So forget about that stupid abortion called "uint32_t" already. It buys
> > you absolutely nothing.
> 
> Now, what do we do with them when they are inside the kernel,
> far from any interfaces ? Live and let live ?

Yes. As long as they don't cause problems, I'm a big fan of "let
developers make their own choices". I think that uint32_t and friends are
totally useless in the kernel, but while I have strong opinions, I try to
not force those opinions on others too much.

Quite frankly, it's unlikely to cause problems in practice. Having strong 
opinions and enjoying the occasional flame war is one thing. Trying to 
rail against other people who don't share those opinions and force them to 
change their code is a totally different thing.

[ It has absolutely nothing to do with me being lazy. Oh, no. I'm not 
  lazy. Much better to attribute it to some lofty goal like "live and let 
  live". If the two just _happen_ to co-incide, all the better ;-]

			Linus
