Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVKURdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVKURdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVKURdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:33:52 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:28620 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932392AbVKURdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:33:52 -0500
Date: Mon, 21 Nov 2005 18:34:05 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: Re: [RFC] Documentation dir is a mess
Message-ID: <20051121173404.GA7886@stiffy.osknowledge.org>
References: <438069BD.6000401@gmail.com> <20051121003033.GA11302@kroah.com> <1132538219.5706.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132538219.5706.36.camel@localhost.localdomain>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt <rostedt@goodmis.org> [2005-11-20 20:56:59 -0500]:

> On Sun, 2005-11-20 at 16:30 -0800, Greg KH wrote:
> > On Sun, Nov 20, 2005 at 01:19:09PM +0100, Xose Vazquez Perez wrote:
> > > hi,
> > > 
> > > _today_ Documentation/* is a mess of files. It would be good
> > > to have the _same_ tree as the code has:
> > 
> > Do you have a proposal as to what specific files in that directory
> > should go where?  Just basing it on the source tree will not get you
> > very far...
> 
> Actually I think it's a good start.  When I'm looking for documentation,
> I usually just do a grep -r on the Documentation directory hoping I get
> a correct hit and then manually look through all the results I get.  It
> does get tedious, and I miss things all the time.

As you're just about to maybe make a decision on reorganisation: how about
a separation of user- and developer-relevant documentation? I mean, kernel
boot parameters are relevant to a user whereas mm/* stuff is not.

Marc
