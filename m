Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280816AbRKGRlx>; Wed, 7 Nov 2001 12:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280865AbRKGRlo>; Wed, 7 Nov 2001 12:41:44 -0500
Received: from www.soccerchix.org ([64.23.60.113]:38417 "EHLO
	gib.soccerchix.org") by vger.kernel.org with ESMTP
	id <S280816AbRKGRle>; Wed, 7 Nov 2001 12:41:34 -0500
Date: Wed, 7 Nov 2001 12:22:42 -0500 (EST)
From: Blue Lang <blue@b-side.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Alexander Viro <viro@math.psu.edu>, Ricky Beam <jfbeam@bluetopia.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <1832004393.1005153898@[10.132.113.67]>
Message-ID: <Pine.LNX.4.30.0111071212430.9535-100000@gib.soccerchix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As an admin, I have to say that there are few things in the world that
cheese me off more than binary logging/statistics. If you change all of
/proc to binary and assume that userspace tools will keep up with changes,
you're eliminating the use of my personal most common set of proc parsing
tools: cat and grep.

With binary, the assumption is made that someone is actually going to
maintain all of those tools, as well as that admins will actually be able
to keep them all straight. It just reeks of AIXness, with the lspv and the
giant nasty ODM database.

I understand where the binary crowd is coming from as far as collation
goes, but I personally use the simple stuff every day (cat /proc/pci) and
any sort of aggregate/collation tool (lspci) almost never.

-- 
   Blue Lang, editor, b-side.org                     http://www.b-side.org
   2315 McMullan Circle, Raleigh, North Carolina, 27608       919 835 1540

