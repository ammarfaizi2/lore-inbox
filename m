Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUK1M3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUK1M3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 07:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUK1M3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 07:29:08 -0500
Received: from levante.wiggy.net ([195.85.225.139]:18101 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261451AbUK1M3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 07:29:06 -0500
Date: Sun, 28 Nov 2004 13:28:55 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       Tonnerre <tonnerre@thundrix.ch>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041128122855.GD17423@wiggy.net>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
	Arjan van de Ven <arjan@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
	Tonnerre <tonnerre@thundrix.ch>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <200411272353.54056.arnd@arndb.de> <1101626019.2638.2.camel@laptop.fenrus.org> <200411281303.46609.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411281303.46609.arnd@arndb.de>
User-Agent: Mutt/1.5.6+20040722i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Arnd Bergmann wrote:
> Ok, I've looked for places where someone actually tried using
> the kernel headers by googling for /usr/include/asm/foo.h.
> The good news is that marking these files broken in 
> glibc-kernheaders has already pointed most authors to the
> source of the problem.

If you want a challenge try if you can get strace to compile with
glibc-kernheaders. 

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
