Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbUK3Xl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbUK3Xl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbUK3XjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:39:06 -0500
Received: from box.punkt.pl ([217.8.180.66]:41485 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S262431AbUK3XKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:10:25 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Wed, 1 Dec 2004 00:08:13 +0100
User-Agent: KMail/1.7
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <200411302344.21907.mmazur@kernel.pl> <20041130230325.GY26051@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041130230325.GY26051@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200412010008.13572.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ¶roda 01 grudzieñ 2004 00:03, Al Viro wrote:
> > Wrong. These dirs must be linked to /usr/include so they must have more
> > meaningfull names.
>
> WTF?  I've got a dozen kernel trees hanging around, which one (and WTF any,
> while we are at it) should be "linked to"?

Linked, copied, mount --binded, whatever. Just not under the 
name /usr/include/user, but something more meaningfull.

And to directly answer your question: you'll 'link' the newest kernel you've 
got around (we all know linux doesn't break abi compatibility, so the newest 
kernel will be fully compatible with all other kernel lying around, right? :)

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
