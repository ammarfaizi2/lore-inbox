Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbTGHOls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbTGHOls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:41:48 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:51212 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267400AbTGHOlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:41:46 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: FAT statfs loop abort on read-error
References: <5.0.2.1.2.20030704123653.03140b70@pop.puretec.de>
	<20030706102410.2becd137.rddunlap@osdl.org>
	<87u19ypc1j.fsf@devron.myhome.or.jp>
	<20030707172431.A26138@infradead.org>
	<874r1xi53w.fsf@devron.myhome.or.jp>
	<20030708133349.A24315@infradead.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Jul 2003 23:56:05 +0900
In-Reply-To: <20030708133349.A24315@infradead.org>
Message-ID: <87smphnk3e.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Jul 08, 2003 at 09:18:43PM +0900, OGAWA Hirofumi wrote:
> > Thank you very much. I try it.
> > 
> > Please apply the following patch.
> 
> You've forgot to add yourself for the generic fat and msdosfs bits :)

Ok. Please apply the following patch.

 MAINTAINERS |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN MAINTAINERS~maintainers-bk6 MAINTAINERS
--- linux-2.5.74/MAINTAINERS~maintainers-bk6	2003-07-08 23:47:05.000000000 +0900
+++ linux-2.5.74-hirofumi/MAINTAINERS	2003-07-08 23:47:36.000000000 +0900
@@ -2103,11 +2103,10 @@ L:	user-mode-linux-user@lists.sourceforg
 W:	http://user-mode-linux.sourceforge.net
 S:	Maintained
 	
-VFAT FILESYSTEM:
-P:	Gordon Chaffee
-M:	chaffee@cs.berkeley.edu
+FAT/VFAT/MSDOS FILESYSTEM:
+P:	OGAWA Hirofumi
+M:	hirofumi@mail.parknet.co.jp
 L:	linux-kernel@vger.kernel.org
-W:	http://bmrc.berkeley.edu/people/chaffee
 S:	Maintained
 
 VIA 82Cxxx AUDIO DRIVER

_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
