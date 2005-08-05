Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbVHEWbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbVHEWbr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVHEWbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:31:47 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:7854 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S263147AbVHEWbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:31:39 -0400
Date: Sat, 6 Aug 2005 00:31:33 +0200
From: David Weinehall <tao@acc.umu.se>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jon Smirl <jonsmirl@gmail.com>, Oliver Neukum <oliver@neukum.org>,
       Greg KH <greg@kroah.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
       dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050805223133.GL9841@khan.acc.umu.se>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Jon Smirl <jonsmirl@gmail.com>, Oliver Neukum <oliver@neukum.org>,
	Greg KH <greg@kroah.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
	dtor_core@ameritech.net, linux-kernel@vger.kernel.org
References: <20050726015401.GA25015@kroah.com> <20050728190352.GA29092@kroah.com> <9e47339105072812575e567531@mail.gmail.com> <200507282310.23152.oliver@neukum.org> <9e47339105072814125d0901d9@mail.gmail.com> <20020101075339.GA467@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020101075339.GA467@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 08:53:39AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > New, simplified version of the sysfs whitespace strip patch...
> > > 
> > > Could you tell me why you don't just fail the operation if malformed
> > > input is supplied?
> > 
> > Leading/trailing white space should be allowed. For example echo
> > appends '\n' unless you know to use -n. It is easier to fix the kernel
> > than to teach everyone to use -n.
> 
> Please, NO! echo -n is the right thing to do, and users will eventually learn.
> We are not going to add such workarounds all over the kernel...

Ahhh, this would be so much easier if people just got used to using
printf instead of echo when doing text output. =)


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
