Return-Path: <linux-kernel-owner+w=401wt.eu-S1758606AbWLIWCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758606AbWLIWCl (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 17:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758738AbWLIWCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 17:02:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52965 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758606AbWLIWCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 17:02:40 -0500
Subject: Re: [NETLINK]: Schedule removal of old macros exported to userspace
From: David Woodhouse <dwmw2@infradead.org>
To: Stefan Rompf <stefan@loplof.de>
Cc: Thomas Graf <tgraf@suug.ch>, David Miller <davem@davemloft.net>,
       drow@false.org, joseph@codesourcery.com, netdev@vger.kernel.org,
       libc-alpha@sourceware.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200612091559.05232.stefan@loplof.de>
References: <20061208.134752.131916271.davem@davemloft.net>
	 <200612091249.39302.stefan@loplof.de>
	 <20061209125533.GO8693@postel.suug.ch>
	 <200612091559.05232.stefan@loplof.de>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 22:02:55 +0000
Message-Id: <1165701775.27042.9.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 15:58 +0100, Stefan Rompf wrote:
> But when even glibc needs internal compat headers to compile with the second 
> kernel version that provides userspace headers, what is the long-term - even 
> mid-term - perspective of make headers_install then?

We've only _just_ started paying attention to what we export. I tried to
keep the initial cut of headers_install very simple and uncontentious --
sticking to implementation, and not policy. So I didn't do a
particularly thorough cull of stuff that we shouldn't be exposing --
it's expected that we may lose _some_ more stuff.

But breaking userspace like _this_ isn't acceptable, and we're not doing
it.

-- 
dwmw2

