Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbTHUFbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 01:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTHUFbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 01:31:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:38104 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262436AbTHUFbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 01:31:15 -0400
Date: Thu, 21 Aug 2003 11:00:41 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O17int
Message-ID: <20030821053041.GB1324@home.woodlands>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200308200102.04155.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308200102.04155.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [19-08-2003 21:26]:
> Food for the starving masses.
[snip]

Yesterday, I got a major lockup with this patch. The system just
completely froze for more than 10 seconds. There was no mouse
movement, I could not switch workspaces.. nothing..

There was quite a bit of load. There were about 180 processes (up from
the normal 40-50) due to a number of procmail/sendmail pairs. I run
spamassassin so each of those processes was testing for spam apart
from my other tests. I was also actively browsing the web and
playing music. Thats about all that was going on. 

Unfortunately I could not get the numbers. Once it passed, everything
was perfectly back to normal. I have not been able to reproduce the
freeze because I have not got enough emails at one go to reproduce
that kind of load. If will try to capture the numbers next time round.

	- Apurva

--
Engineers motto: cheap, good, fast: choose any two
