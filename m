Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTBCCRk>; Sun, 2 Feb 2003 21:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTBCCRk>; Sun, 2 Feb 2003 21:17:40 -0500
Received: from dp.samba.org ([66.70.73.150]:7910 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265667AbTBCCRi>;
	Sun, 2 Feb 2003 21:17:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [2.5] initrd/mkinitrd still not working 
In-reply-to: Your message of "Sun, 02 Feb 2003 10:28:41 CDT."
             <Pine.LNX.3.96.1030202102324.22592A-100000@gatekeeper.tmr.com> 
Date: Mon, 03 Feb 2003 11:59:01 +1100
Message-Id: <20030203022709.896C72C0A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.3.96.1030202102324.22592A-100000@gatekeeper.tmr.com> you w
rite:
> On Wed, 29 Jan 2003, Rusty Russell wrote:
> > Ah, sorry for the confusion.
> 
> So does this mean you are washing your hands of Redhat users, or that you
> will convert the Debian package to tar or other portable format useful to
> all users including non-debian?

No, but I'm pretty sure it means that we don't want either mkinitrd
included in module-init-tools.  I have no idea whether the two are
even compatible.

I certainly don't have the expertise to maintain either one: they both
seem to have happy, active maintainers who *do* know what they are
doing.

FYI, .deb files have the nice feature that they can be extracted using
standard tools: "file foo.deb" should tell it is a standard ar
archive.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
