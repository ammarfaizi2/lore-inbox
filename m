Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVEOIyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVEOIyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 04:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVEOIyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 04:54:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51628 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261566AbVEOIyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 04:54:06 -0400
Date: Sun, 15 May 2005 10:54:05 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4e vs git network pull
Message-ID: <20050515085405.GB13024@pasky.ji.cz>
References: <20050512094406.GZ5914@waste.org> <20050512182340.GA324@pasky.ji.cz> <20050512201116.GC5914@waste.org> <20050512201406.GJ324@pasky.ji.cz> <20050512205735.GE5914@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512205735.GE5914@waste.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 10:57:35PM CEST, I got a letter
where Matt Mackall <mpm@selenic.com> told me that...
> Does this need an HTTP request (and round trip) per object? It appears
> to. That's 2200 requests/round trips for my 800 patch benchmark.

Yes it does. On the other side, it needs no server-side CGI. But I guess
it should be pretty easy to write some kind of server-side CGI streamer,
and it would then easily take just a single HTTP request (telling the
server the commit ID and receiving back all the objects).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
