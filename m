Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUGVKI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUGVKI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 06:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUGVKI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 06:08:58 -0400
Received: from mproxy.gmail.com ([216.239.56.248]:49322 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S264685AbUGVKI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 06:08:57 -0400
Message-ID: <4d8e3fd304072203081918cd7@mail.gmail.com>
Date: Thu, 22 Jul 2004 12:08:56 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] delete devfs
Cc: Greg KH <greg@kroah.com>, Jesse Stockall <stockall@magma.ca>,
       linux-kernel@vger.kernel.org, rgooch@safe-mbox.com, akpm@osdl.org
In-Reply-To: <200407221155.13004.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040721141524.GA12564@kroah.com> <200407220047.53153.oliver@neukum.org> <20040722064952.GC20561@kroah.com> <200407221155.13004.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2004 11:55:12 +0200, Oliver Neukum <oliver@neukum.org> wrote:
> Am Donnerstag, 22. Juli 2004 08:49 schrieb Greg KH:
> > > Interesting, but we are not talking about an _internal_ API here.
> > > It's about blocking the upgrade path.
> >
> > There is no such block.  udev has a full devfs compatibility mode, I made
> > sure of that before every suggesting that a change like this happen.
> 
> A smooth upgrade is replacing the kernel image, rerun lilo and reboot.
> There's very good reason to remove devfs from 2.7.0, but almost none
> to remove it from 2.6.X (unless Richard turns up and rewrites it from scratch)
> Breaking existing setup is acceptable only if you can do nothing else.

I tend to agree with you even though I still have to read the "MOM" regarding
what has been discussed yesterday.

If I'm not wrong, there is not plan to fork a 2.7 kernel anytime soon,
so this kind of patch that brokes only a few users will probably be included
in 2.6.*

Ciao,

-- 
paoloc.doesntexist.org
