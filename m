Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267545AbUH1TEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267545AbUH1TEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUH1TEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:04:02 -0400
Received: from alias.nmd.msu.ru ([193.232.127.67]:29711 "EHLO alias.nmd.msu.ru")
	by vger.kernel.org with ESMTP id S267545AbUH1TDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:03:53 -0400
Date: Sat, 28 Aug 2004 23:03:50 +0400
From: Alexander Lyamin <flx@msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexander Lyamin <flx@msu.ru>, Christoph Hellwig <hch@lst.de>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re:   reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040828190350.GA14152@alias>
Reply-To: flx@msu.ru
Mail-Followup-To: flx@msu.ru, Linus Torvalds <torvalds@osdl.org>,
	Christoph Hellwig <hch@lst.de>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, reiserfs-list@namesys.com
References: <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <20040828105929.GB6746@alias> <Pine.LNX.4.58.0408281011280.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408281011280.2295@ppc970.osdl.org>
X-Operating-System: Linux 2.6.5-7.104-smp
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sat, Aug 28, 2004 at 10:18:44AM -0700, Linus Torvalds wrote:
>
>
> On Sat, 28 Aug 2004, Alexander Lyamin wrote:
> >
> > VFS never was "an integral part" of ANY filesystem. my dog knows it.
>
> That's not really true.

Theres some truth. And its really arguably, but I think, I see your point.

And taking on the situation with reiser4 with "smartmost VFS" approach,
time should pass and with time and expirience on hands it will be evident what
should go in VFS. Now its may be too early.

Considering "amazing PR skills" of Hans Reiser it was the only viable way
to get this changes in VFS. Cause, ironically, mr. Hellwig that currently
demand it to be scrapped out or go in VFS would instakill Hans Reiser
(i know many people would:) if he only touched holy cow of VFS for any
reiser4 purpose.

As I told before, some technically right things just do not work in this
imperfect world. You have to count with social issues, and Hans Reiser
wont, he just avoid them whenever its possible. 

> Name handling (dentry layer, mounting) is very much an integral part of
> the filesystem. Almost everything else in the VFS is "helper functions",
> ie a filesystem can choose to ignore buffer heads, page cache etc, but a 
> filesystem really cannot ignore or override the VFS naming stuff.
> 
> (Arguably the page cache isn't part of the VFS layer at all, it's really a 
> memory management thing, although it's so intertwined with the VFS helper 
> functions that you can't really draw the line).
> 
> > its just unified INTERFACE TO any filesystem (including reiser4).
> 
> True, but that's not the whole truth. It's way more than just an
> interface. It's a set of rules, and it's in many way the controlling
> party.
> 
> 		Linus

"True, but thats not the whole truth."

-- 
"the liberation loophole will make it clear.."
lex lyamin
