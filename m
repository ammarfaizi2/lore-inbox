Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262535AbTCRT2p>; Tue, 18 Mar 2003 14:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbTCRT2p>; Tue, 18 Mar 2003 14:28:45 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:7437 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S262535AbTCRT2o>; Tue, 18 Mar 2003 14:28:44 -0500
Message-Id: <200303181939.h2IJd8C7007744@pincoya.inf.utfsm.cl>
To: Bob Miller <rem@osdl.org>
cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: modutils for 2.5 
In-reply-to: Your message of "Mon, 17 Mar 2003 13:40:18 PST."
             <20030317214018.GA13643@doc.pdx.osdl.net> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Tue, 18 Mar 2003 15:39:07 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Miller <rem@osdl.org> said:
> On Mon, Mar 17, 2003 at 02:37:11PM -0500, jlnance@unity.ncsu.edu wrote:

[...]

> > Any idea if installing this break a redhat-8 kernel upgrade?  I
> > updated modutils some time ago and it does not seem very happy
> > with 2.4 kernels now.  I was using RPMs because I want to keep
> > the package manager informed about which packages are installed.
> > Perhaps there was a problem with the way the RPMs were made rather
> > than the tools.

> Please read the README that comes with the package, it explains this
> and other issues in more detail. In a nut shell you will need to save
> away the currently installed tools so they can be used by "older"
> kernels.

They are not used by older kernels, if the new tool finds out that the
kernel is old, it exec(3)s the old tool. In particular, if you build a new
initrd with mkinitrd(8), it will _only_ package the new tool, and
everything goes south on boot.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
