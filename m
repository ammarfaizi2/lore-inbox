Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266363AbSKLJhB>; Tue, 12 Nov 2002 04:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbSKLJhB>; Tue, 12 Nov 2002 04:37:01 -0500
Received: from AGrenoble-101-1-1-247.abo.wanadoo.fr ([193.251.23.247]:2029
	"EHLO awak") by vger.kernel.org with ESMTP id <S266363AbSKLJgy> convert rfc822-to-8bit;
	Tue, 12 Nov 2002 04:36:54 -0500
Subject: Re: devfs
From: Xavier Bestel <xavier.bestel@free.fr>
To: Ian Molton <spyro@f2s.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021112093259.3d770f6e.spyro@f2s.com>
References: <20021112093259.3d770f6e.spyro@f2s.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Nov 2002 10:43:41 +0100
Message-Id: <1037094221.16831.21.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 12/11/2002 à 10:32, Ian Molton a écrit :
> On 11 Nov 2002 20:50:39 -0500
> Robert Love <rml@tech9.net> wrote:
> 
> > On Mon, 2002-11-11 at 20:32, Ryan Anderson wrote:
> > 
> > > From an outsider point of view (and because nobody else responded),
> > > I think the big question here would be: Would you use it after this
> > > cleanup?
> > > 
> > > If you say yes, I'd say that's a good sign in its favor.
> > 
> > Good heuristic, except Al would not use devfs in either case :)
> 
> Personally I love devfs. I've not looked at its internals, but its never
> failed me yet, and I like the way /dev only contains stuff that actually
> exists.

I'm wondering if a totally userspace solution could replace devs ?
Something using hotplug + sysfs and creating directories/nodes as they
appear on the system. This way, the policy (how do I name what) could be
moved out of the kernel.

	Xav

