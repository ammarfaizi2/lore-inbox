Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281361AbRKEVph>; Mon, 5 Nov 2001 16:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281362AbRKEVp2>; Mon, 5 Nov 2001 16:45:28 -0500
Received: from taltos.codesourcery.com ([66.92.14.85]:7300 "EHLO
	taltos.codesourcery.com") by vger.kernel.org with ESMTP
	id <S281361AbRKEVpM>; Mon, 5 Nov 2001 16:45:12 -0500
Date: Mon, 5 Nov 2001 13:45:08 -0800
From: Zack Weinberg <zack@codesourcery.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.20a and gcc 3.0 ?
Message-ID: <20011105134508.O267@codesourcery.com>
In-Reply-To: <20011104192024.H267@codesourcery.com> <3BE68F75.3010300@stesmi.com> <20011105120143.M267@codesourcery.com> <3BE6FE99.8020400@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE6FE99.8020400@stesmi.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 10:03:21PM +0100, Stefan Smietanowski wrote:
> Hi!
> 
> 
> >>I know how it's done, it's just that in my eyes a stable release is the 
> >>one where you know there's only 1 .... A 2.95.4 package built on 
> >>different days (from CVS) will differ. A 2.95.4 package built on 
> >>different ways from a .tar.gz marked as 'release' will not differ.
> >>
> >>For instance chasing a kernel bug is difficult when 1 person might use 1 
> >>version of a compiler and another uses a different version when both 
> >>says 2.95.4, no matter how miniscule the difference.
> >>
> >
> >Since patches are being applied to the 2.95 branch at a rate of about
> >one a month, I think the date stamp in the version number should be
> >quite sufficient to avoid any problems along these lines.
> 
> If it's tested and rock stable, why isn't it released?

It would be silly to generate a new 2.95.x point release every time we
fix a bug - most of them are minor, affect very few people, and the
fixes will get picked up by the distros anyway.

There probably will be a 2.95.4 official release at some point,
but again I'm not aware of any current plans.

zw
