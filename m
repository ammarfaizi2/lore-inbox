Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbUARWaj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 17:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUARWaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 17:30:39 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:53231 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S264252AbUARWai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 17:30:38 -0500
Date: Sun, 18 Jan 2004 23:30:25 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Andries.Brouwer@cwi.nl
cc: axboe@suse.de, <linux-kernel@vger.kernel.org>
Subject: Re: Making MO drive work with ide-cd
In-Reply-To: <UTC200401181718.i0IHI5F26519.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0401182328290.2544-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jan 2004 Andries.Brouwer@cwi.nl wrote:

> Hmm. Looked at it. But it cannot help. All it does is move
> cdrom_read_capacity().

That's enough for unpartitioned disks. It works here.

> But ide-cd remains fundamentally broken for disks.
> It sends cdrom commands, and they fail, and it does not do
> disk things that are needed. First of all, we need partitions,
> but ide-cd.c puts g->minors = 1.

Well, I'm welcome to other ideas, but to me everything is the
better than the current mainline 2.6 situation - which is "doesn't
work at all, no matter what you try".

The ide-cd solution doesn't get you partitions, but using the
medium as a superfloppy works for me.

-- 
Ciao,
Pascal

