Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269288AbUICIt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269288AbUICIt0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbUICIrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:47:42 -0400
Received: from mail1.kontent.de ([81.88.34.36]:28636 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S269368AbUICI3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:29:14 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: The argument for fs assistance in handling archives
Date: Fri, 3 Sep 2004 10:30:58 +0200
User-Agent: KMail/1.6.2
Cc: David Masover <ninja@slaphack.com>, Spam <spam@tnonline.net>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <20040826150202.GE5733@mail.shareable.org> <4137BE36.5020504@slaphack.com> <20040903091352.A2288@infradead.org>
In-Reply-To: <20040903091352.A2288@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409031030.58319.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 3. September 2004 10:13 schrieb Christoph Hellwig:
> On Thu, Sep 02, 2004 at 07:43:34PM -0500, David Masover wrote:

> > | There's no need to do that in kernel, unless you want to be able
> > | to force it unto users.
> > 
> > And on apps.  Should I teach OpenOffice.org to do version control?
> > Seems a lot easier to just do it in the kernel, and teach everything to
> > do version control in one fell swoop.
> 
> Just add a post-save trigger that can check it into any SCM you want.

That depends on whom you refer to. If you want to impose the RCS
on the users as an administrative measure and force compliance, then
you'll need to do it in kernel.
I see some nasty issues with disk quotas there.

	Regards
		Oliver
