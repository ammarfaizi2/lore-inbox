Return-Path: <linux-kernel-owner+w=401wt.eu-S964947AbXAHWAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbXAHWAH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbXAHWAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:00:06 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:17725 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964947AbXAHWAE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:00:04 -0500
Date: Mon, 8 Jan 2007 22:00:00 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-ID: <20070108220000.GA27950@deepthought>
References: <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <20070107182151.7cc544f3@localhost.localdomain> <Pine.LNX.4.61.0701072011510.4365@yvahk01.tjqt.qr> <20070107223055.1dc7de54@localhost.localdomain> <Pine.LNX.4.61.0701080221500.28861@yvahk01.tjqt.qr> <Pine.LNX.4.61.0701082010230.23737@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701082010230.23737@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 09:17:06PM +0100, Jan Engelhardt wrote:
> 
> On Jan 8 2007 02:22, Jan Engelhardt wrote:
> >On Jan 7 2007 22:30, Alan wrote:
> >>
> >>> >The kernel maintainers/help/config pretty consistently use UTF8
> >>> 
> >>> I've seen a lot of places that don't do so. Want a patch?
> >>
> >>I think that would be a good idea - and add it to the coding/docs specs
> >>that documentation is UTF-8. Code should IMHO say 7bit though.
> 
> Most memorable issues:
> 
> * "don<decimal-180>t" (standalone accent aigu) rather than "don't" (apostrophe)
> * "<decimal-160>", non breaking spaces
> * cp437 encoding in some files (heh, heh, DOS!)
> * iso8859-1/utf-8 mixed in some files
 Looks nicely done, but I query the postal address changes in
Documentation/cdrom/sbpcd - that seems to be a change of address
(without anything to explain it).  Everything else seems to be just
character-set conversion or the occasional translation of comments
into English.  (And no, I didn't attempt to review the character-set
changes, even it there is an occasional error it will be better than
where we are now, and easy to patch.)
> 
> My compose key is hot now...
 I prefer the AltGr dead keys in X (they seem to work more reliably
for me), but I guess I'm straying OT.
> 
> None of you people screw that patch with your buggy MUAs! I'll pack
> it up into a .bz2 to get it marked as application/octet-stream to
> not even give your MUA the chance to. ;-) [and because it's 221 K 
> uncompressed and I am not sure if splitting it up makes much sense for 
> such 'trivial' changes, or not?]
> 
> Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
> 
> 
> 	-`J'
> -- 

 Thanks for doing this, I hope it wasn't in vain.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
