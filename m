Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUHEPLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUHEPLn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267752AbUHEPLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:11:43 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:19718 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267751AbUHEPLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:11:32 -0400
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8-rc3
References: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org>
	<200408041407.39871.lkml@kcore.org>
	<20040804124042.GA25969@harddisk-recovery.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 06 Aug 2004 00:10:00 +0900
In-Reply-To: <20040804124042.GA25969@harddisk-recovery.com>
Message-ID: <87657xtyd3.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> writes:

> >        iocharset=value
> >               Character set to use for converting between 8 bit characters and
> >               16 bit Unicode characters. The default is iso8859-1.  Long file-
> >               names are stored on disk in Unicode format.
> > 
> > the default is iso8859-1. Has this default gone haywire somewhere?
> 
> Yes, it's in the hidden in the ChangeLog. You can find it if you know
> iocharset is the same as nls:
> 
>   Hirofumi Ogawa:
>     o FAT: kill nls default

Or Documentation/filesystems/vfat.txt
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
