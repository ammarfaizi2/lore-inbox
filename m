Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273559AbSKECrt>; Mon, 4 Nov 2002 21:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273560AbSKECrt>; Mon, 4 Nov 2002 21:47:49 -0500
Received: from pop017pub.verizon.net ([206.46.170.210]:5585 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S273559AbSKECrs>; Mon, 4 Nov 2002 21:47:48 -0500
Message-Id: <200211050251.gA52pvSE005904@pool-141-150-241-241.delv.east.verizon.net>
Date: Mon, 4 Nov 2002 21:51:56 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.46 1/10: Core definitions
References: <3DC727CD.96EE29AE@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC727CD.96EE29AE@opersys.com>; from karim@opersys.com on Mon, Nov 04, 2002 at 09:07:09PM -0500
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop017.verizon.net from [141.150.241.241] at Mon, 4 Nov 2002 20:54:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> 
> Apparently Linus doesn't see what this patch buys Linux. Since
> I can't personally convince him otherwise, having written LTT
> myself, here it is in the hope that others on the list actually
> find it of some use.

I've had LTT in my own tree for a while now.  I appreciate all of the
work you've done.

If anyone wants to use it without applying each LTT patch, my tree is
at http://members.verizon.net/~vze2j9fk

But beware, this is my own tree that I play with.  It has all of kprobes
and LTT right now.  It usually also has LKCD, but right now it's out
because I couldn't do the merge from the last version (2.5.44.)  It'll
be back as soon an updated LKCD is available.

Also as Karim noted, you'll have to recompile the LTT userland tools
to change the number of syscalls.  You may also have to upgrade your
binutils for the initramfs merge.

-- 
Skip
