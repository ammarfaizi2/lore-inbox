Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263853AbUCZAdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUCZAdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:33:01 -0500
Received: from mail.tpgi.com.au ([203.12.160.58]:49575 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263853AbUCZAGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:06:34 -0500
Subject: Re: swsusp with highmem, testing wanted
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040325235440.GL2179@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz>
	 <1080185300.1147.62.camel@gaston> <20040325120250.GC300@elf.ucw.cz>
	 <1080254461.1195.40.camel@gaston> <20040325225946.GI2179@elf.ucw.cz>
	 <1080254675.7097.16.camel@calvin.wpcb.org.au>
	 <20040325235440.GL2179@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080256008.7294.30.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Fri, 26 Mar 2004 11:06:48 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-03-26 at 11:54, Pavel Machek wrote:
> > 10x more code is true, but we also need to ask, how much of that is more
> > functionality? How much is debugging code (that can be removed)? How
> > much is comments?
> 
> Do you think you could strip down features + debugging etc so that
> swsusp2 is only, say, 3x bigger than swsusp1? It would certainly make
> merging easier.

Well, I'll certainly clean up the debugging code. I know that much of it
isn't needed any more. I'll try not to remove comments though :> (I know
it's not simple and straightforward to understand how it works, so I
want to comment it as well as I can. As I said the other day, I don't
intend to disappear into the wild blue yonder, but I don't know what the
future will bring).

> > 10x implies there's needless bloat and that the two are otherwise
> > equivalent. That's simply not true.
> 
> If I implied that I should appologize. (Sorry.) swsusp2 *has* more
> features, many of them make it faster.

No offense taken. I just wanted to make it clear we're not comparing
apples with apples here.

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

