Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUADJZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 04:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265159AbUADJZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 04:25:56 -0500
Received: from codepoet.org ([166.70.99.138]:56515 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S265155AbUADJZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 04:25:53 -0500
Date: Sun, 4 Jan 2004 02:25:53 -0700
From: Erik Andersen <andersen@codepoet.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] FAT: Support the large partition (> 128GB) for 2.4
Message-ID: <20040104092553.GA13986@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <87k74or58m.fsf@devron.myhome.or.jp> <20031231091359.GA13996@codepoet.org> <87d6a0rsiw.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d6a0rsiw.fsf@devron.myhome.or.jp>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jan 04, 2004 at 06:07:35PM +0900, OGAWA Hirofumi wrote:
> Erik Andersen <andersen@codepoet.org> writes:
> 
> > > This is used for updates (not create) of the directory entry, and
> > > overflowed by large partition (> 128GB).
> > 
> > I think this additional fat32 patch would be a good idea for
> > 2.4.x.  Could you review these changes and perhaps fold them into
> > your patch for inclusion into 2.4.x.  This patch fixes support
> > for the full 4GB (-1 bytes) allowable fat32 file size, and should
> > be added onto of your previous patch for large fat32 filesystems.
> 
> Basically looks good. But it was forgetting to fix the mmu_private of
> some filesystems.

Yes, I suppose all filesystems should be fixed.

> If previous patch was applied and someone didn't submit this stuff,
> I'll try it.

That would be great.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
