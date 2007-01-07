Return-Path: <linux-kernel-owner+w=401wt.eu-S932573AbXAGPNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbXAGPNm (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbXAGPNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:13:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58664 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932573AbXAGPNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:13:40 -0500
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
From: David Woodhouse <dwmw2@infradead.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <45A0F060.9090207@imap.cc>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	 <20070107114439.GC21613@flint.arm.linux.org.uk>  <45A0F060.9090207@imap.cc>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 23:13:57 +0800
Message-Id: <1168182838.14763.24.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-07 at 14:06 +0100, Tilman Schmidt wrote:
> Russell King schrieb:
> > Welcome to the mess which the UTF-8 charset creates.

Utter bollocks.

> The problem of different character encodings coexisting on the same
> platform, and the resulting occasional messing-up, far predates Unicode.
> I distinctly remember one case of being bitten by this myself in 1977
> when Unicode wasn't even on the horizon yet, and I don't think that was
> the first time.

Indeed. If you take arbitrary content and send it out to the world
labelled as ISO8859-1, of _course_ you're likely to be corrupting it.

Far from being the cause of the problem, UTF-8 actually offers the
chance of a _solution_. Because once the Luddites catch up, it'll
largely eliminate the need for using the multitude of legacy character
sets and converting between them -- and the problem of mislabelling will
fairly much go away.

-- 
dwmw2

