Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbTAZWyK>; Sun, 26 Jan 2003 17:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbTAZWyK>; Sun, 26 Jan 2003 17:54:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:13517 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267032AbTAZWyI>; Sun, 26 Jan 2003 17:54:08 -0500
Date: Mon, 27 Jan 2003 00:56:46 +0100
From: Christian Zander <zander@minion.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christian Zander <zander@minion.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030126235646.GI394@kugai>
Reply-To: Christian Zander <zander@minion.de>
References: <20030126232839.GF394@kugai> <20030126220842.GB394@kugai> <20030123193540.GD13137@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301261054250.15538-100000@chaos.physics.uiowa.edu> <28922.1043617222@passion.cambridge.redhat.com> <30455.1043621199@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30455.1043621199@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 10:46:39PM +0000, David Woodhouse wrote:
> 
> Ok, but why else would you want your own makefiles if that's not
> that you wanted them for?
> 

Essentially because they already existed and worked (well enough).

> True, but in this case you are voicing concern about the potential
> breakage of something which was always known to be bad practice,
> fragile and unreliable.
> 
> Your expression of concern is noted, but with about as much sympathy
> as is granted to those who express concern because kernel headers
> which they were including from userspace have changed.
> 
> Yes, it breaks if you invent you own makefiles. We knew that.  Don't
> Do That Then -- or if you must, then just deal with it breaking in
> the kernel-de-jour.
> 

Fair enough.

> 'make -C $LINUXDIR SUBDIRS=$PWD modules' has worked for as long as
> I can remember; it's not new in 2.5. It's _always_ been the only
> reliable way to get kernel modules to build with the correct
> options.
> 

Since Linux 2.2 and including any specifics involved in the process of
customizing CFLAGS, ...? If that's the case, I admit ignorance and ask
that my earlier remarks be ignored.

-- 
christian zander
zander@minion.de
