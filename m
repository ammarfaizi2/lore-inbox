Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTFVIf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 04:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTFVIf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 04:35:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59398 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264025AbTFVIfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 04:35:24 -0400
Date: Sun, 22 Jun 2003 09:49:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@digeo.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>, alan@lxorguk.ukuu.org.uk,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
Message-ID: <20030622094910.A10063@flint.arm.linux.org.uk>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Chris Wedgwood <cw@f00f.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@digeo.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, alan@lxorguk.ukuu.org.uk,
	perex@suse.cz, linux-kernel@vger.kernel.org
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com> <20030622001101.GB10801@conectiva.com.br> <20030622014102.GB29661@dingdong.cryptoapps.com> <20030622014345.GD10801@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030622014345.GD10801@conectiva.com.br>; from acme@conectiva.com.br on Sat, Jun 21, 2003 at 10:43:45PM -0300
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 10:43:45PM -0300, Arnaldo Carvalho de Melo wrote:
> I don't know, I was just trying to figure out the impact of requiring gcc 3
> to compile the kernel. I never used gcc 2.96 btw.

So, for ARM, we end up with the following gcc versions which appear to
work:

	- gcc 2.95.3 + patch
	- gcc 2.95.4
	- gcc 3.2.2 + patch
	- gcc 3.2.3 + patch
	- gcc 3.3

(Some of the gcc people may beg to differ, but the above list results
from many reports and real life experiences from several people.)

>From what I understand, the gcc people are not all that happy about
the gcc 3.2.x patch, based upon the fact that it has not been applied.
It is also possible that gcc 3.3 happens to work because the bug got
hidden by other changes, or, the real bug did get fixed.  No one seems
to know.  Certainly the bugzilla entry remains open and unresolved.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

