Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVAMUXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVAMUXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVAMUCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:02:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29875 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261469AbVAMUAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:00:31 -0500
Date: Thu, 13 Jan 2005 14:59:02 -0500
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       grendel@caudium.net, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113195901.GB3555@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, grendel@caudium.net,
	Linus Torvalds <torvalds@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
	akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050113032506.GB1212@redhat.com> <20050113035331.GC9176@beowulf.thanes.org> <1105627951.4664.32.camel@localhost.localdomain> <20050113192512.GA27607@infradead.org> <20050113193356.GA3555@redhat.com> <20050113193524.GA27785@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113193524.GA27785@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 > >  > > 2.6.9 for example went out with known holes and broken AX.25 (known) 
 > >  > > 2.6.10 went out with the known holes mostly fixed but memory corrupting
 > >  > > bugs, AX.25 still broken and the wrong fix applied for the smb holes so
 > >  > > SMB doesn't work on it
 > >  > XFS on 2.6.10 does work.
 > 
 > freudian typo, should have been smbfs as it should be obvious for the
 > context I replied to.

The smbfs breakage depended on what server you were using it seemed.
For a lot of folks it broke horribly.

 > > Depends on your definition of 'work'.
 > > It oopses under load with NFS very easily,
 > Do you have a bugreport?

There are number of XFS related issues in Red Hat bugzilla.
As its not something we actively support, they've not got a lot
of attention. Some of them are quite old (dating back to 2.6.6 or so)
so may already have got fixed.

We've also seen a few reports on Fedora mailing lists.

		Dave

