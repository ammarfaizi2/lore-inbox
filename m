Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUIELkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUIELkn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUIELkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:40:24 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:25092 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266474AbUIELkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:40:05 -0400
Message-ID: <2f4958ff04090504405243fc38@mail.gmail.com>
Date: Sun, 5 Sep 2004 13:40:02 +0200
From: =?UTF-8?Q?Grzegorz_Ja=C5=9Bkiewicz?= <gryzman@gmail.com>
Reply-To: =?UTF-8?Q?Grzegorz_Ja=C5=9Bkiewicz?= <gryzman@gmail.com>
To: Tonnerre <tonnerre@thundrix.ch>
Subject: Re: silent semantic changes with reiser4
Cc: Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040905111743.GC26560@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
	 <m3eklm9ain.fsf@zoo.weinigel.se> <20040905111743.GC26560@thundrix.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004 13:17:43 +0200, Tonnerre <tonnerre@thundrix.ch> wrote:
> Salut,
> 
> On Wed, Sep 01, 2004 at 01:02:24AM +0200, Christer Weinigel wrote:
> > I can see the argument for having the equivalent of Content-type or
> > Content-transfer-encoding as a named stream though.
> 
> Why having them as  named streams if we can get them  as xattrs for no
> additional pain? (Since fileutils would  have to be changed anyway, we
> can even make cp copy and emacs update xattrs.)

Because some of as requested to be able to open tar,iso, and few other
formats this way. So I can simply access it with cat (as a dir/file).



-- 
GJ
