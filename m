Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUJLOPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUJLOPy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUJLOPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:15:54 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:5 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264085AbUJLOPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:15:53 -0400
Date: Tue, 12 Oct 2004 15:15:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041012141546.GA19360@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain> <20041012131124.GA2484@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012131124.GA2484@IBM-BWN8ZTBWA01.austin.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 08:11:24AM -0500, Serge E. Hallyn wrote:
> > That however requires a co-operator outside the chroot so doesn't seem
> > to be a problem. I like the CLONE approach, its a lot cleaner.
> 
> The attached patch (against -rc4-mm1) moves the responsibility for
> filesystem containment entirely to userspace.  The Documentation/bsdjail.txt
> file reflects the new usage.  It also incorporates Christoph's cleanups.
> 
> I still need to see about generalizing the networking confinement.  I
> certainly like the concept (as I understand it at least) behind the new
> vserver networking, but am not sure it can be done without patching.

Please remember that linux kernel work is not about "not needing patching".
If a concept makes sense changing code is a good thing.
