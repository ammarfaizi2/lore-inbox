Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbUK2VWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUK2VWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 16:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUK2VWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 16:22:23 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:24783 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261806AbUK2VWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 16:22:18 -0500
Message-Id: <200411292120.iATLKZxE004233@laptop11.inf.utfsm.cl>
To: Christian Mayrhuber <christian.mayrhuber@gmx.net>
cc: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>, reiserfs-list@namesys.com,
       Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory 
In-Reply-To: Message from Christian Mayrhuber <christian.mayrhuber@gmx.net> 
   of "Sat, 27 Nov 2004 14:14:18 BST." <200411271414.18801.christian.mayrhuber@gmx.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 29 Nov 2004 18:20:35 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Mayrhuber <christian.mayrhuber@gmx.net> said:
> On Saturday 27 November 2004 12:09, Peter Foldiak wrote:
> > On Fri, 2004-11-26 at 21:13, Christian Mayrhuber wrote:
> > > Regarding namespace unification + XPath:
> > > For files: cat /etc/passwd/[. = "joe"] should work like in XPath.
> > 
> > I don't understand this. Why would you need the "."? And why the /
> > between passwd and [ ?
> Yes, I was confused by /etc/passwd/[username] in an earlier email.
> I think we both mean basically the same.

Now think about files with other formats, for instance the (in)famous
sendmail.cf, or less structured stuff like you find in /etc/init.d/, or
just Postgres databases (with fun stuff like permissions on records and
fields)... or just people groping in /etc/passwd wanting to find the whole
entry (not just one field), or perhaps look at the 15th character of the
entry for John Doe.

This way lies utter madness (what format description should be applied to
what file this time around?). Plus shove all this garbage into the kernel?!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
