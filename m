Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265186AbSJaGOx>; Thu, 31 Oct 2002 01:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265191AbSJaGOx>; Thu, 31 Oct 2002 01:14:53 -0500
Received: from tapu.f00f.org ([66.60.186.129]:58595 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S265186AbSJaGOw>;
	Thu, 31 Oct 2002 01:14:52 -0500
Date: Wed, 30 Oct 2002 22:21:18 -0800
From: Chris Wedgwood <cw@f00f.org>
To: tridge@samba.org
Cc: torvalds@transmeta.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, geert@linux-m68k.org,
       rmk@arm.linux.org.uk, peter@chubb.wattle.id.au, tytso@mit.edu
Subject: Re: What's left over.
Message-ID: <20021031062118.GA18007@tapu.f00f.org>
References: <20021031030143.401DA2C150@lists.samba.org> <20021031031954.56C772C156@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031031954.56C772C156@lists.samba.org>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 10:19:54PM -0500, tridge@samba.org wrote:

> Eventually I'd like to see a combination of LSM with a new ACL
> system give the ability to support full NT ACLs on Linux (which is
> also needed for full nfsv4 support), but that is way too much to do
> for the 2.6 kernel.

Add bloat to make windows clients happy?

> Extended attributes are also important as they give a place to store
> all the extra DOS info that has no other logical place in a posix
> filesystem. For example, we can put the 'read only', 'archive',
> 'hidden' and 'system' attributes there. If we don't have extended
> attributes then we need to use a nasty kludge where these map to
> various unix permission bits, but the mapping is terrible and
> doesn't give the correct semantics (especially for things like read
> only on directories).

More bloat that does really solve Linux problems... sounds like nasty
hacks to make winduhs hacks work better.

Don't get me wrong, I'm not against sane ACLs (POSIX ACLs are not) os
EAs, but justification of "it makes windows clients easier" is pretty
horrendous IMO.

I'd would at some point like to see decent ACLs, but I don't want to
see 'windows ACLs' and all the SID nonsense.



  --cw
