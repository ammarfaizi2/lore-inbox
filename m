Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265985AbUFUBqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUFUBqD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 21:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265696AbUFUBqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 21:46:02 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:20740 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265985AbUFUBpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 21:45:10 -0400
To: arjanv@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] FAT: don't use "utf8" charset and NLS_DEFAULT
References: <200406201807.i5KI7qNT004770@hera.kernel.org>
	<1087767944.2805.20.camel@laptop.fenrus.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 21 Jun 2004 10:44:55 +0900
In-Reply-To: <1087767944.2805.20.camel@laptop.fenrus.com>
Message-ID: <87brjdd6qw.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Sun, 2004-06-20 at 18:59, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1770, 2004/06/20 09:59:33-07:00, hirofumi@mail.parknet.co.jp
> > 
> > 	[PATCH] FAT: don't use "utf8" charset and NLS_DEFAULT
> > 	
> > 	Recently, some distributors have set "utf8" to NLS_DEFAULT, therefore,
> > 	FAT uses the "iocharset=utf8" as default.  But, since "iocharset=utf8"
> > 	doesn't provide the function (lower <-> upper conversion) which FAT
> > 	needs, so FAT can't provide suitable behavior.
> 
> does Microsoft store UTF8 in vfat ?

No, Microsoft doesn't store UTF8 in vfat.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
