Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbULAFXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbULAFXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 00:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbULAFXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 00:23:10 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:24688 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261174AbULAFXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 00:23:05 -0500
Date: Wed, 1 Dec 2004 06:23:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041201052328.GA8157@mars.ravnborg.org>
Mail-Followup-To: Mariusz Mazur <mmazur@kernel.pl>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Alexandre Oliva <aoliva@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
	Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
	hch@infradead.org, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <200411302344.21907.mmazur@kernel.pl> <20041130230325.GY26051@parcelfarce.linux.theplanet.co.uk> <200412010008.13572.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412010008.13572.mmazur@kernel.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 12:08:13AM +0100, Mariusz Mazur wrote:
> On ?roda 01 grudzie? 2004 00:03, Al Viro wrote:
> > > Wrong. These dirs must be linked to /usr/include so they must have more
> > > meaningfull names.
> >
> > WTF?  I've got a dozen kernel trees hanging around, which one (and WTF any,
> > while we are at it) should be "linked to"?
> 
> Linked, copied, mount --binded, whatever. Just not under the 
> name /usr/include/user, but something more meaningfull.

Whats wrong with
/lib/modules/`uname -r`/source/include/user
/lib/modules/`uname -r`/source/include/$arch

	Sam
