Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUIGG3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUIGG3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 02:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267605AbUIGG3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 02:29:09 -0400
Received: from holomorphy.com ([207.189.100.168]:54173 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267598AbUIGG3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 02:29:04 -0400
Date: Mon, 6 Sep 2004 23:28:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hans Reiser <reiser@namesys.com>
Cc: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>,
       Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040907062806.GL3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hans Reiser <reiser@namesys.com>,
	David Masover <ninja@slaphack.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
	Tonnerre <tonnerre@thundrix.ch>,
	Christer Weinigel <christer@weinigel.se>,
	Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200409070206.i8726vrG006493@localhost.localdomain> <413D4C18.6090501@slaphack.com> <413D4ED9.5090206@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413D4ED9.5090206@namesys.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 11:02:01PM -0700, Hans Reiser wrote:
> I just want to remind that no one has been able to offer a good way of 
> handling attributes/streams/metafiles other than reiser4 in which 
> CTRL-XCTRL-Ffilename within emacs to edit the stream/attribute/metafile 
> will work without modifying the emacs source.  David Masover is right 
> that there are far more application writers than kernel hackers, and we 
> should make the kernel more complicated if it makes a few thousand apps 
> simpler.

This thread is getting a bit soft on technical details and/or value.

Hans, please post the results of fsstress (the bits from ext3 cvs) on
reiser4 on SMP machines of non-i386 architectures (e.g. ppc64, sparc64,
ia64) as well as the results of transferring reiser4 filesystems
between machines whose PAGE_SIZE, wordsize and endianness vary.


-- wli
