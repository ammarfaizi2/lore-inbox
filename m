Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbUK3Wy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbUK3Wy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUK3Wy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:54:26 -0500
Received: from [213.146.154.40] ([213.146.154.40]:24037 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262376AbUK3Wvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:51:46 -0500
Date: Tue, 30 Nov 2004 22:51:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130225128.GA31216@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Alexandre Oliva <aoliva@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
	Matthew Wilcox <matthew@wil.cx>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <1101828924.26071.172.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org> <1101832116.26071.236.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org> <1101837135.26071.380.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org> <20041130224851.GH8040@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130224851.GH8040@waste.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a) during the transition, include/linux/foo.h includes
> include/user/foo.h if it exists and similarly for asm-*
> b) when include/user is deemed sufficiently populated, a flag day is
> declared and links from /usr/include are switched to them

there are no such links, only copies (more or less modified)

