Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUKHRHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUKHRHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUKHRGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:06:55 -0500
Received: from [213.146.154.40] ([213.146.154.40]:17355 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261925AbUKHQYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:24:53 -0500
Subject: Re: bk-commits: diff -p?
From: David Woodhouse <dwmw2@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.61.0411081715450.4130@waterleaf.sonytel.be>
References: <Pine.LNX.4.61.0411080940310.27771@anakin>
	 <1099929091.4542.83.camel@hades.cambridge.redhat.com>
	 <Pine.GSO.4.61.0411081715450.4130@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1099931089.4542.94.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 08 Nov 2004 16:24:49 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 17:16 +0100, Geert Uytterhoeven wrote:
> On Mon, 8 Nov 2004, David Woodhouse wrote:
> > On Mon, 2004-11-08 at 09:41 +0100, Geert Uytterhoeven wrote:
> > > Would it be possible to enable the `-p' option (Show which C function each
> > > change is in) of diff for all patches sent to the bk-commits-* mailing lists?
> > 
> > I did consider that but 'bk diffs -up' gives a context diff, not a
> > unified diff.
> 
> So it's a `regression' of bk diffs vs. GNU diff?

Possibly. Certainly it's the reason my export scripts don't use -p. If
it's deemed a bug and once it's 'fixed' on kernel.org, we can change
that.

-- 
dwmw2

