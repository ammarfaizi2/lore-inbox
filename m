Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268720AbUIGWix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268720AbUIGWix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268724AbUIGWix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:38:53 -0400
Received: from holomorphy.com ([207.189.100.168]:64418 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268720AbUIGWir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:38:47 -0400
Date: Tue, 7 Sep 2004 15:38:01 -0700
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
Message-ID: <20040907223801.GS3106@holomorphy.com>
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
References: <200409070206.i8726vrG006493@localhost.localdomain> <413D4C18.6090501@slaphack.com> <413D4ED9.5090206@namesys.com> <20040907062806.GL3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907062806.GL3106@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 11:28:06PM -0700, William Lee Irwin III wrote:
> This thread is getting a bit soft on technical details and/or value.
> Hans, please post the results of fsstress (the bits from ext3 cvs) on
> reiser4 on SMP machines of non-i386 architectures (e.g. ppc64, sparc64,
> ia64) as well as the results of transferring reiser4 filesystems
> between machines whose PAGE_SIZE, wordsize and endianness vary.

Okay, sounds like time to run these tests and post the results myself.

Hans, these things should be part of your standard QA. It would likely
make a better impression if there were some record of these kinds of
things having been successfully tested prior to your releases. For
future reference, Andrew, Christoph, myself, and others can provide
more detailed references to suites of stress tests and various kinds of
tests filesystems should pass before being considered stable, and we
(it's a relatively safe presumption that I speak for all of us when I
say this) would appreciate this kind of testing in the future.


-- wli
