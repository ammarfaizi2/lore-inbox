Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUGMK6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUGMK6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 06:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUGMK6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 06:58:42 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:3568 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264808AbUGMK6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 06:58:40 -0400
Date: Tue, 13 Jul 2004 03:58:20 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Tim Connors <tconnors@astro.swin.edu.au>,
       ismail d?nmez <ismail.donmez@gmail.com>
Cc: Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040713105819.GA3262@taniwha.stupidest.org>
References: <20040713080950.GA1810@taniwha.stupidest.org> <E1BkJgc-0002Sb-O5@a4.complang.tuwien.ac.at> <20040713095300.GA2986@taniwha.stupidest.org> <slrn-0.9.7.4-25266-13316-200407132020-tc@hexane.ssi.swin.edu.au> <2a4f155d04071303384f156004@mail.gmail.com> <20040713080950.GA1810@taniwha.stupidest.org> <E1BkJgc-0002Sb-O5@a4.complang.tuwien.ac.at> <20040713095300.GA2986@taniwha.stupidest.org> <slrn-0.9.7.4-25266-13316-200407132020-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4f155d04071303384f156004@mail.gmail.com> <slrn-0.9.7.4-25266-13316-200407132020-tc@hexane.ssi.swin.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 08:27:30PM +1000, Tim Connors wrote:

> KDE is a peice of shit with regards to file handling.

I personally would like to see KDE made more robust here (since I use
it myself).  I'm guessing it's probably not hard but I don't have a
good feeling as the few times I have hacked KDE I was pretty
disappointed how bad the code is.

That said, my guess is common code handles most of this stuff so the
right fixes in one or two places would probably cover everything.

> Makes me glad I use a much more sane WM, but I pity those 3 users in
> the space of a few minutes who lost all of their settings.

I back my .kde ever now and then as a precaution.  It's generally not
a problem for me but as mentioned I am aware KDE could be better in
this regard.

Loosing window manager settings is a pain, loosing data from knotes
and your bookmarks is very much more frustrating though.



On Tue, Jul 13, 2004 at 01:38:40PM +0300, ismail d?nmez wrote:

> Trying to start a flame war with bitching about KDE?

I'm not sure he was.

> How about trying to solve at least work around it?

He doesn't use it, why would he bother?

On the other hand, one day I might (I hope someone else does before
me, the KDE code is scary).

Since so many files are involved (I have 350 in my .kde) I suspect
properly fixing this is going to be more involved that write, fsync,
rename but it probably wouldn't be a bad place to start (only 43 of
them were modified in the last day).


  --cw
