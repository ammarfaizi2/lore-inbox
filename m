Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbRBYFhG>; Sun, 25 Feb 2001 00:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129859AbRBYFg4>; Sun, 25 Feb 2001 00:36:56 -0500
Received: from www.wen-online.de ([212.223.88.39]:3858 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129851AbRBYFgp>;
	Sun, 25 Feb 2001 00:36:45 -0500
Date: Sun, 25 Feb 2001 06:36:40 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Shawn Starr <spstarr@sh0n.net>
cc: lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Patch failed
In-Reply-To: <3A9719FE.D84B70FB@sh0n.net>
Message-ID: <Pine.LNX.4.33.0102250624001.1656-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, Shawn Starr wrote:

> Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 2-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 1-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 2-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 1-order allocation failed.
>
> didnt, work, still causing this..

What does free output look like after abort?  (is someone leaking or
is all memory just temporarily tied up?)

	-Mike

