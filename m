Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVAMTmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVAMTmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVAMTku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:40:50 -0500
Received: from [213.146.154.40] ([213.146.154.40]:30872 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261404AbVAMTfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:35:34 -0500
Date: Thu, 13 Jan 2005 19:35:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, grendel@caudium.net,
       Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113193524.GA27785@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	grendel@caudium.net, Linus Torvalds <torvalds@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
	akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050113032506.GB1212@redhat.com> <20050113035331.GC9176@beowulf.thanes.org> <1105627951.4664.32.camel@localhost.localdomain> <20050113192512.GA27607@infradead.org> <20050113193356.GA3555@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113193356.GA3555@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 02:33:56PM -0500, Dave Jones wrote:
>  > On Thu, Jan 13, 2005 at 03:36:33PM +0000, Alan Cox wrote:
>  > > 2.6.9 for example went out with known holes and broken AX.25 (known) 
>  > > 2.6.10 went out with the known holes mostly fixed but memory corrupting
>  > > bugs, AX.25 still broken and the wrong fix applied for the smb holes so
>  > > SMB doesn't work on it
>  > 
>  > XFS on 2.6.10 does work.

freudian typo, should have been smbfs as it should be obvious for the
context I replied to.

> Depends on your definition of 'work'.
> It oopses under load with NFS very easily,

Do you have a bugreport?

