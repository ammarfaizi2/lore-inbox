Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTGHMFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTGHMFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:05:09 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:38154 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265152AbTGHMFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:05:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: FAT statfs loop abort on read-error
References: <5.0.2.1.2.20030704123653.03140b70@pop.puretec.de>
	<20030706102410.2becd137.rddunlap@osdl.org>
	<87u19ypc1j.fsf@devron.myhome.or.jp>
	<20030707172431.A26138@infradead.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Jul 2003 21:18:43 +0900
In-Reply-To: <20030707172431.A26138@infradead.org>
Message-ID: <874r1xi53w.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Jul 08, 2003 at 12:54:48AM +0900, OGAWA Hirofumi wrote:
> > > (I asked him to add a patch to MAINTAINTERS...)
> > 
> > Thank you. But honestly, I may not have skill enough.
> 
> Given that you have done a nice job ob fatfs in 2.5 and there's no one
> coming near that many useful contributions in that timeframe I think
> it would be a good idea to declare you maintainer.  According to
> MAINTAINERS it currently doesn't have any formal maintainer anyway.

Thank you very much. I try it.

Please apply the following patch.

 MAINTAINERS |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -puN MAINTAINERS~maintainers MAINTAINERS
--- linux-2.5.74/MAINTAINERS~maintainers	2003-07-08 20:58:35.000000000 +0900
+++ linux-2.5.74-hirofumi/MAINTAINERS	2003-07-08 21:00:18.000000000 +0900
@@ -2089,10 +2089,9 @@ W:	http://user-mode-linux.sourceforge.ne
 S:	Maintained
 	
 VFAT FILESYSTEM:
-P:	Gordon Chaffee
-M:	chaffee@cs.berkeley.edu
+P:	OGAWA Hirofumi
+M:	hirofumi@mail.parknet.co.jp
 L:	linux-kernel@vger.kernel.org
-W:	http://bmrc.berkeley.edu/people/chaffee
 S:	Maintained
 
 VIA 82Cxxx AUDIO DRIVER

_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
