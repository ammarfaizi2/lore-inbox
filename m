Return-Path: <linux-kernel-owner+w=401wt.eu-S933004AbWL1K2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbWL1K2i (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933010AbWL1K2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:28:38 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48853 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933004AbWL1K2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:28:37 -0500
X-Sasl-enc: K1mvaK5qqENwFqkpANffJFOTmLgTZINSF9SuOsnpONJa 1167301644
Date: Thu, 28 Dec 2006 19:28:51 +0900 (WST)
From: Ian Kent <raven@themaw.net>
To: Theodore Tso <tytso@mit.edu>
cc: Karel Zak <kzak@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: util-linux: orphan
In-Reply-To: <20061227204212.GA21393@thunk.org>
Message-ID: <Pine.LNX.4.64.0612281920400.5917@raven.themaw.net>
References: <20061109224157.GH4324@petra.dvoda.cz> <200612270346.10699.arnd@arndb.de>
 <20061227181510.GB17785@petra.dvoda.cz> <200612271939.48125.arnd@arndb.de>
 <20061227191824.GC17785@petra.dvoda.cz> <20061227204212.GA21393@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Dec 2006, Theodore Tso wrote:

> On Wed, Dec 27, 2006 at 08:18:24PM +0100, Karel Zak wrote:
> >  Frankly, it wasn't always easy to use SeLinux in previous FC
> >  releases, but there is huge progress and I think it's much better in
> >  FC6.
> 
> I've never tried SELinux, but at one point there were all sorts of
> horror stories that if you enabled SELinux, the moment you installed
> any 3rd party software packages, whether it's Oracle or Websphere or
> some other commercial application program, the application would break
> because of all sorts of SELinux policy violations, and that it
> required an SELinux wizard to configure SELinux policy to enable a 3rd
> party application to actually work correctly.  Given that I tried
> enabling SELinux, witnessed things break spectacularly and with no
> hints about how to fix things, I've always had the attitude of "life
> is too short to enable SELinux", and so my limited experience is
> consistent with all of the horror stories that I've heard.

I see the fine grained security of Selinux as a big problem for third 
party applications.

It's a big job to make the OS work cleanly with it but the fact is that 
many machines need to run significant 3rd party applications. I don't have 
first hand experience but I suspect most vendors have tight enough budgets 
without adding an Selinux developer and customers usually don't have this 
resource either so, by and large, I expect people will just have to 
disable it.

I really don't see any solution to this problem either.
Time will tell.

Ian
