Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbTCHQ5O>; Sat, 8 Mar 2003 11:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262172AbTCHQ5N>; Sat, 8 Mar 2003 11:57:13 -0500
Received: from bitmover.com ([192.132.92.2]:65412 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262170AbTCHQ5K>;
	Sat, 8 Mar 2003 11:57:10 -0500
Date: Sat, 8 Mar 2003 09:07:41 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, zippel@linux-m68k.org,
       david.lang@digitalinsight.com, hpa@zytor.com, rmk@arm.linux.org.uk,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Message-ID: <20030308170741.GB29789@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	"David S. Miller" <davem@redhat.com>, zippel@linux-m68k.org,
	david.lang@digitalinsight.com, hpa@zytor.com, rmk@arm.linux.org.uk,
	greg@kroah.com, linux-kernel@vger.kernel.org
References: <20030308.080317.27972826.davem@redhat.com> <Pine.LNX.4.44.0303080826300.2954-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303080826300.2954-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 08:35:24AM -0800, Linus Torvalds wrote:
> Also, you guys should think about what this whole project was about: it's 
> about the smallest possible libc. This is NOT a project that should live 
> and prosper and grow successful. That's totally against the whole point of 
> it, it's not _supposed_ to ever be a glibc-like thing. It's supposed to be 
> so damn basic that it's not even _interesting_. It's one of those projects 
> that is better off ignored, in fact. It's like a glorified header file.
> 
> (At this point hpa asks me to shut up, since I've now depressed him more
> than any of the GPL bigots ever did ;)

Actually, I think this libc is very useful and at the risk of depressing hpa
even more, we may well link BitKeeper against it.  We make no use of anything
glibc specific since we run on all sorts of platforms and having libc be
part of the image would be cool if it were small.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
