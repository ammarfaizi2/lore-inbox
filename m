Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbSJIPKf>; Wed, 9 Oct 2002 11:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbSJIPKJ>; Wed, 9 Oct 2002 11:10:09 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:56839 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261804AbSJIPJH>; Wed, 9 Oct 2002 11:09:07 -0400
Date: Wed, 9 Oct 2002 17:14:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "J.A. Magallon" <jamagallon@able.es>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Brendan J Simon <brendan.simon@bigpond.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
In-Reply-To: <20021009144502.GD2954@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0210091705160.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Oct 2002, J.A. Magallon wrote:

> >stick with TCL/TK, like xconfig currently uses ?
> >or is it not sufficient?  or just too ugly?
> >
>
> What is linux kernel conf written in ?
> - perl: use perl-gtk (I think there is also a perl-qt)
> - python: use py-gtk...
>
> Use whatever the language gives. I never undestook why use tcl/tk
> on a perl/python config system.

With the exception of the X interface everything is in C, what makes it
difficult to use script languages, one always needs some extra development
package installed. That's the main reason for creating a library backend,
a lot can already be packaged by distributions and only the library needs
to be built from the current kernel.

bye, Roman

