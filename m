Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268160AbUHaWJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbUHaWJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUHaWJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:09:56 -0400
Received: from launch.server101.com ([216.218.196.178]:43706 "EHLO
	mail-pop3-1.server101.com") by vger.kernel.org with ESMTP
	id S267978AbUHaWC3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:02:29 -0400
From: Tim Fairchild <tim@bcs4me.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: K3b and 2.6.9?
Date: Wed, 1 Sep 2004 08:01:30 +1000
User-Agent: KMail/1.6.1
Cc: ismail =?iso-8859-1?q?d=F6nmez?= <ismail.donmez@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408301047.06780.tim@bcs4me.com> <2a4f155d04083113162c2759ea@mail.gmail.com> <Pine.LNX.4.58.0408311332410.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408311332410.2295@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409010801.30118.tim@bcs4me.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 Sep 2004 06:33, Linus Torvalds wrote:
> On Tue, 31 Aug 2004, ismail dönmez wrote:
> > Checked k3b on CVS and it does this now :
> >
> >   int flags = O_NONBLOCK;
> >   if( write )
> >     flags |= O_RDWR;
> >   else
> >     flags |= O_RDONLY;
> > .....
> >   fd = ::open( name, flags );
> >
> > which already fixes the issue. Right?
>
> I assume so, assuming that the "write" flag is set correctly. Somebody
> would need to test whether it actually works for them ;)

Will test more here as soon as possible which may be a couple of days as I 
will be away from the computer...

Thanks all very much.

tim
