Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSKCEEi>; Sat, 2 Nov 2002 23:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSKCEEi>; Sat, 2 Nov 2002 23:04:38 -0500
Received: from waste.org ([209.173.204.2]:38880 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261593AbSKCEEf>;
	Sat, 2 Nov 2002 23:04:35 -0500
Date: Sat, 2 Nov 2002 22:10:55 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "davej@suse.de" <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103041055.GE18884@waste.org>
References: <20021103035017.GD18884@waste.org> <Pine.LNX.4.44.0211022052180.20616-100000@mooru.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211022052180.20616-100000@mooru.gurulabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 09:00:38PM -0700, Dax Kelson wrote:
> On Sat, 2 Nov 2002, Oliver Xymoron wrote:
> 
> > # mkcapwrap +net_raw ping.real
>
> Do you mean?
> 
> # mkcapwrap +net_raw ping

Actually I meant:

# mkcapwrap +net_raw ping.real ping

..in keeping with ln(1).

> The wrapper needs to setuid/gid to the uid/gid that invokes it.

Generally, though there'd need to be an option to emulate, say, setgid
mail.

> Currently all capabilities are cleared when non-root app does a execp. 
> This would need to be addressed.

Hrmm. I thought the inherit mask dealt with that. 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
