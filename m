Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbTLINXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbTLINXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:23:12 -0500
Received: from aun.it.uu.se ([130.238.12.36]:43196 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265663AbTLINXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 08:23:10 -0500
Date: Tue, 9 Dec 2003 14:23:05 +0100 (MET)
Message-Id: <200312091323.hB9DN5T7028976@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] number of Solaris slices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Dec 2003 23:17:22 +0100 (MET), Andries.Brouwer@cwi.nl wrote:
>People tell me that SOLARIS_X86_NUMSLICE should be 16 instead of 8.
>And it seems there is some truth in that.
>
>On the other hand, there have certainly been times that 8 was the
>right number. Instead of using a define for the number of slices
>(partitions, if you prefer), is it OK for all Solaris versions to
>use v->v_nparts?

Your patch didn't break my dual boot Linux + Sol8 x86 box.
It has about 8 slices in the Solaris partition.

/Mikael
