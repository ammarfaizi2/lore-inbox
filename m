Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSGaA31>; Tue, 30 Jul 2002 20:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317522AbSGaA31>; Tue, 30 Jul 2002 20:29:27 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:60040 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317482AbSGaA30>; Tue, 30 Jul 2002 20:29:26 -0400
Date: Tue, 30 Jul 2002 18:32:48 -0600
Message-Id: <200207310032.g6V0WmW12258@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <Pine.LNX.4.44.0207310149450.28515-100000@serv>
References: <200207302341.g6UNfDF11136@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0207310149450.28515-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> Hi,
> 
> On Tue, 30 Jul 2002, Richard Gooch wrote:
> 
> > > As far as I can see it's still broken wrt to module unloading.
> >
> > No, it's not. Look more closely.
> 
> Are you sure it's save in devfs_open() too?

Yes. RTFS.

> Even if it's save/fixed, it's still code duplication.

No. I leverage fops_get(), a common function.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
