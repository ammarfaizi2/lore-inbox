Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269684AbUICNTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269684AbUICNTy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269675AbUICNTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:19:54 -0400
Received: from dsl092-149-163.wdc2.dsl.speakeasy.net ([66.92.149.163]:38923
	"EHLO localhost") by vger.kernel.org with ESMTP id S269689AbUICNQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:16:48 -0400
Subject: Re: The argument for fs assistance in handling archives
From: Brian Beattie <beattie@beattie-home.net>
To: Christer Weinigel <christer@weinigel.se>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <m3llfsikis.fsf@zoo.weinigel.se>
References: <20040826150202.GE5733@mail.shareable.org>
	 <200408282314.i7SNErYv003270@localhost.localdomain>
	 <20040901200806.GC31934@mail.shareable.org>
	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>
	 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
	 <4136A14E.9010303@slaphack.com>
	 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
	 <4136C876.5010806@namesys.com>
	 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
	 <4136E0B6.4000705@namesys.com> <14260000.1094149320@flay>
	 <m3llfsikis.fsf@zoo.weinigel.se>
Content-Type: text/plain
Message-Id: <1094217399.2954.9.camel@kokopelli>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 09:16:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 14:38, Christer Weinigel wrote:
> "Martin J. Bligh" <mbligh@aracnet.com> writes:
> 
> > > For 30 years nothing much has happened in Unix filesystem semantics 
> > > because of sheer cowardice 
> > 
> > Or because it works fine, and isn't broken.
> 
> I've heard the same argument a lot of times.  People complaining that
> Unix is so seventies because it sticks to the old boring philosophy of
> everything is a file and that a file is a stream of bytes, nothing
> more.  Modern operating systems such as VMS with basic database
> handling in the OS itself, or MacOS or NT with named streams is so
> much more modern.  Why don't we get with the times?

Actually the handleing of special filesystem features in the OS is an
OLD idea.  VMS is actually not more modern than Unix, it is older than
Unix owing much to earlier OS's such as RSX-11.  It was a great insight
on the part of Ritche and Thompson that the kernel should present a file
as a byte stream and that the interpretation of the contents of a file
is the province of the application, not the operating system.

Now it maybe, that there are features that can only be provided by
adding support in the kernel, but we should be very careful not to be
distracted by what we see as new wizbang features.  The filesystem as a
database has been tried before, ISAM is a very old concept.

> 
> It may be because just because of the simplicity it's fairly easy to
> use, harder to break och does one thing well.  If you want structured
> storage, use a database, on top of the low level primitives, or use
> multiple files in a directory.  Why complicate things?
> 
>   /Christer
-- 
Brian Beattie   LFS12947 | "Honor isn't about making the right choices.
beattie@beattie-home.net | It's about dealing with the consequences."
www.beattie-home.net     | -- Midori Koto


