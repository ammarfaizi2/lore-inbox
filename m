Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbULaMNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbULaMNn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 07:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbULaMNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 07:13:43 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:687 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261868AbULaMNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 07:13:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: Kill O(n^2) algorithm in swsusp
Date: Fri, 31 Dec 2004 13:13:53 +0100
User-Agent: KMail/1.7.1
Cc: Eduard Bloch <edi@gmx.de>, Pavel Machek <pavel@suse.cz>
References: <20041225175453.GA10222@elf.ucw.cz> <20041231112625.GA28483@zombie.inka.de>
In-Reply-To: <20041231112625.GA28483@zombie.inka.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412311313.53797.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 31 of December 2004 12:26, Eduard Bloch wrote:
> #include <hallo.h>
> * Pavel Machek [Sat, Dec 25 2004, 06:54:54PM]:
> > Hi!
> > 
> > Some machines are spending minutes of CPU time during suspend in
> > stupid O(n^2) algorithm. This patch replaces it with O(n) algorithm,
> > making swsusp usable to some people.
> > 
> > I'd like people to test this. It should probably spend few weeks 
> 
> Has been working quite stable for some days now (and countless reboots)
> with kernel 2.6.9. And is as fast as swsusp2 (but works reliable ;-).

Confirmed.  I've been running it for quite some time with 2.6.10 on an AMD64 
and it works great.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
