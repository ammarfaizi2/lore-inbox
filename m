Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUFIRPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUFIRPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUFIRPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:15:25 -0400
Received: from mail.dif.dk ([193.138.115.101]:53993 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266218AbUFIRPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:15:18 -0400
Date: Wed, 9 Jun 2004 19:14:33 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Robert White <rwhite@casabyte.com>
Cc: "'Ingo Molnar'" <mingo@elte.hu>, "'Christoph Hellwig'" <hch@infradead.org>,
       "'Mike McCormack'" <mike@codeweavers.com>, linux-kernel@vger.kernel.org
Subject: RE: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAWUyJbbFwtUuY/ZGbgGI8TwEAAAAA@casabyte.com>
Message-ID: <Pine.LNX.4.56.0406091911340.26677@jjulnx.backbone.dif.dk>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAWUyJbbFwtUuY/ZGbgGI8TwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2004, Robert White wrote:

> I would think that having an easy call to disable the NX modification would be both
> safe and effective.  That is, adding a syscall (or whatever) that would let you mark
> your heap and/or stack executable while leaving the new default as NX, is "just as
> safe" as flagging the executable in the first place.
>

Just having the abillity to turn protection off opens the door. If it is
possible to turn it off then a way will be found to do it - either via
buggy kernel code or otherwhise. Only safe approach is to have it
enabled by default and not be able to turn it off IMHO.


--
Jesper Juhl <juhl-lkml@dif.dk>

