Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131350AbRBWRew>; Fri, 23 Feb 2001 12:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbRBWRel>; Fri, 23 Feb 2001 12:34:41 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:16280 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S131350AbRBWRec>;
	Fri, 23 Feb 2001 12:34:32 -0500
Date: Fri, 23 Feb 2001 18:34:23 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Carl D. Speare" <carlds@attglobal.net>
Cc: Quim K Holland <qkholland@my-deja.com>, linux-kernel@vger.kernel.org
Subject: Re: need to suggest a good FS:
Message-ID: <20010223183423.N5465@khan.acc.umu.se>
In-Reply-To: <20010223143235.E5465@khan.acc.umu.se> <Pine.BSF.4.33.0102231216030.4359-100000@topgun.unixexchange.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.BSF.4.33.0102231216030.4359-100000@topgun.unixexchange.com>; from carlds@attglobal.net on Fri, Feb 23, 2001 at 12:20:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2001 at 12:20:34PM -0500, Carl D. Speare wrote:
> Actually there isn't. Hmmm, sounds like I'll have some hacking to do...
> 
> But I have to ask if this is something that would actually be desirable.
> Given how rare it is, does the Linux community actually want to have YAFS
> (yet another file system) added to the list, especially for an even more
> rare OS like OpenServer 5.0.x? Maybe now that Caldera is involved more
> with SCO, it might be something that happens in a few months anyway...

Make a read-only version; this will make transition from HTFS to
{ext2fs, reiserfs, xfs, jfs, ...} easy. Read-only also has the property
that it won't cause on-disk corruption; at worst, you get in-memory
corruption...


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
