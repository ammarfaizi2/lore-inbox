Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUFTRzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUFTRzL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUFTRzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:55:09 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:18957 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265285AbUFTRyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:54:05 -0400
To: Eduard Bloch <edi@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT: doesn't recognize "iocharset=utf8" and doesn't use
 NLS_DEFAULT
References: <87659mjnps.fsf@devron.myhome.or.jp>
	<20040620160656.GA14769@zombie.inka.de>
	<87u0x6i0qx.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 21 Jun 2004 02:53:57 +0900
In-Reply-To: <87u0x6i0qx.fsf@devron.myhome.or.jp>
Message-ID: <87pt7ui096.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> > > NOTE: the following looks like buggy, so it's not recommended
> > > 
> > >     "codepage=437,iocharset=iso8859-1,utf8"
> > > 
> > > however, some utf8 file name can handle. (in this case, it uses the
> > > table of iso8859-1 for lower <-> upper conversion)
> 
> > Isn't this a task for the FAT16-names access method?
> 
> Yes, but 8.3-alias is stored always even if it's long name.

And of course table is also used for case insensible access.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
