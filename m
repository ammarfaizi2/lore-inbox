Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269448AbUHZTSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269448AbUHZTSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269316AbUHZTKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:10:24 -0400
Received: from main.gmane.org ([80.91.224.249]:60600 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269418AbUHZTHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:07:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: silent semantic changes with reiser4
Date: Thu, 26 Aug 2004 21:06:43 +0200
Message-ID: <MPG.1b98216351280e1f9896d7@news.gmane.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826010355.GB24731@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-103-141.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Cc: reiserfs-list@namesys.com, linux-fsdevel@vger.kernel.org
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Nicholas Miell wrote:
> > Anything that currently stores a file's metadata in another file really
> > wants this right now. Things like image thumbnails, document summaries,
> > digital signatures, etc.
> 
> Additionally, all of those things you describe should be deleted if
> the file is modified -- to indicate that they're no longer valid and
> should be regenerated if needed.

In principle, not all of them. For example, a document summary 
for a text document or a long (textual) description of a video 
clip might remain the same when the user is only working on the 
finishing details.

Maybe the metadata needs an attribute to determine how 
'immutable' it should be wrt changes on the file? (Can you 
spell meta-meta-data <g>)

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

