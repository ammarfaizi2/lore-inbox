Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVAMIXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVAMIXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVAMIXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:23:36 -0500
Received: from [213.146.154.40] ([213.146.154.40]:45199 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261192AbVAMIXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:23:32 -0500
Date: Thu, 13 Jan 2005 08:23:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113082320.GB18685@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
	Greg KH <greg@kroah.com>, chrisw@osdl.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 08:48:57PM -0800, Linus Torvalds wrote:
> Without that capability set, you can only execute binaries that you cannot
> write to, and that you cannot _get_ write permission to (ie you can't be
> the owner of them either - possibly only binaries where the owner is
> root).

I think this is called "mount user-writeable filesystems with -noexec" ;-)

