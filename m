Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132421AbRCZLvC>; Mon, 26 Mar 2001 06:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132423AbRCZLuw>; Mon, 26 Mar 2001 06:50:52 -0500
Received: from spaans.ds9a.nl ([213.244.168.214]:51644 "HELO spaans.ds9a.nl")
	by vger.kernel.org with SMTP id <S132421AbRCZLum>;
	Mon, 26 Mar 2001 06:50:42 -0500
Date: Mon, 26 Mar 2001 13:49:53 +0200
From: Jasper Spaans <j@sp3r.net>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Matthew Chappee <matthew@mattshouse.com>, dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM handling
Message-ID: <20010326134953.A10461@spaans.ds9a.nl>
In-Reply-To: <3ABDF8A6.7580BD7D@evision-ventures.com> <45961.192.168.1.5.985572801.squirrel@matthew.mattshouse.com> <20010326133305.A8133@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010326133305.A8133@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Mon, Mar 26, 2001 at 01:33:05PM +0200
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2001 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 01:33:05PM +0200, Ingo Oeser wrote:
> > The point being, my database shouldn't be selected for
> > termination.  Nobody ever got fired for kill -9'ing netscape,
> > but Oracle is a different story.  I urge you, consider the
> > patch.
> 
> No, you got fired for not setting ulimits. Your boss is right
> then!
> 
> ulimit -d 65536
> ulimit -v 81920

Ehm, right.

Running netscape (or any other memory hog which doesn't belong on a server)
on a production server seems reason enough for a little talk with your boss.

On the other hand, if no other apps are running on your box, and Oracle gets
killed due to OOM, you probably have underestimated your hardware needs, or
Oracle has gone haywire, which is a good reason for killing it.

Thus, nothing seems wrong with the current kill algorithm to me...

Just my two cents,
-- 
  Q_.           Jasper Spaans <j@sp3r.net>
 `~\            http://jsp.ds9a.nl/
Mr /\           Tel/Fax: +31-20-8749842
Zap             Move all .sig for great justice!
