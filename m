Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbTDBObt>; Wed, 2 Apr 2003 09:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263013AbTDBObt>; Wed, 2 Apr 2003 09:31:49 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:43481 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S263012AbTDBObs>; Wed, 2 Apr 2003 09:31:48 -0500
Date: Thu, 3 Apr 2003 00:44:32 +1000
From: CaT <cat@zip.com.au>
To: Christoph Rohland <cr@sap.com>
Cc: Hugh Dickins <hugh@veritas.com>, tomlins@cam.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Message-ID: <20030402144432.GB536@zip.com.au>
References: <Pine.LNX.4.44.0304011734370.1503-100000@localhost.localdomain> <ovd6k5l60d.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ovd6k5l60d.fsf@sap.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 09:20:50AM +0200, Christoph Rohland wrote:
> If you now were able to take advantage of additional swap
> automatically administration would be a no brainer. Also distributions

Sounds like what you want is a dynamically resizing tmpfs based on the
amount of memory (ram+swap) available. That's a much bigger goose to fry
I believe.

Now, even if the percentile patch took into account swap, you'd still
need to remount tmpfs in order to get it to take into account of any
swap you add on the fly.

> could add much saner defaults for /dev/shm or even use it for /tmp.

I use it for /tmp now just fine. :) It's sized at 63% of 256MB of RAM.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)
