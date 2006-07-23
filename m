Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWGWSZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWGWSZE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 14:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWGWSZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 14:25:04 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:10148
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751172AbWGWSZC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 14:25:02 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Tomasz =?utf-8?q?K=C5=82oczko?= <kloczek@rudy.mif.pg.gda.pl>
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Date: Sun, 23 Jul 2006 20:24:43 +0200
User-Agent: KMail/1.9.1
References: <44C099D2.5030300@s5r6.in-berlin.de> <20060723112005.GA6815@martell.zuzino.mipt.ru> <Pine.BSO.4.63.0607231929350.10018@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.63.0607231929350.10018@rudy.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607232024.43237.mb@bu3sch.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 July 2006 19:55, Tomasz Kłoczko wrote:
> On Sun, 23 Jul 2006, Alexey Dobriyan wrote:
> [..]
> >> Again: using indent mainly will mean only one time massive changes.
> >
> > True, 180M(!) of them.
> 
> ~160M.
> And this is so huge now because seems there is no obligation use common 
> format .. all is formated using hands/mind/difftent editors autoformaters.
> 
> >> After
> >> this ident can be runed for example by Linus just before make release
> >> and/or partial release.
> >
> > ~4M per run.
> 
> If patch submmitter will use formating tool and it will add it will statr 
> work on formated source tree it will be 0M per run.
> 
> >>> scripts/Lindent exists and gets used, but it is not perfect.
> >
> > Correction: GNU indent exists and gets used, but it is not perfect.
> 
> Yes .. and produce by Lindent ~160MB patch it excelent proof how offent is 
> is used now :>
> (please stop this crap "argumentation" :>)

Yeah, please stop it.
Did you actually _look_ at what indent does to code sometimes?
It sometimes (often?) renders perfectly readable code into a
huge blob of crap.

Face reality. The linux kernel is following the general codingstyle
very well already. I don't think there is need to improve the current
codebase for non-existent codingstyle issues. And we already review
new code for codingstyle issues, so the codebase remains clean.

Look at other projects with horrible codingstyle problems
and suggest solutions to their _real_ issues. *cough*kde*cough*

-- 
Greetings Michael.
