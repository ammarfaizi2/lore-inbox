Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbUK3QhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbUK3QhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbUK3QfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:35:04 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:3307 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262170AbUK3Qd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:33:27 -0500
Message-Id: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory 
In-Reply-To: Message from Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> 
   of "30 Nov 2004 15:29:40 -0000." <1101828580.17826.165.camel@pear.st-and.ac.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 30 Nov 2004 13:31:29 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> said:
> On Tue, 2004-11-30 at 14:51, Horst von Brand wrote:
> > > I was suggesting this idea mainly form XML files, where the tags define 
> > > the parts clearly.

> > Use a XML parsing library then.

> But namespace unification is important,

Why? Directories are directories, files are files, file contents is file
contents. Mixing them up is a bad idea. Sure, you could build a filesystem
of sorts (perhaps more in the vein of persistent programming, or even data
base systems) where there simply is no distinction (because there are no
differences to show), but that is something different.

>                                         and to unify the namespace, you
> have to use the same syntax. I guess you disagree with me on that. (If
> not, how would you do it?)

I'd go one level up: Eliminate the distinctions that bother you, not try to
patch over them.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
