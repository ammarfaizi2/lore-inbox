Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282874AbRLGQpa>; Fri, 7 Dec 2001 11:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRLGQpV>; Fri, 7 Dec 2001 11:45:21 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:21684 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S282907AbRLGQpJ>; Fri, 7 Dec 2001 11:45:09 -0500
Message-Id: <200112071645.fB7GjLE03441@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: <linux-kernel@vger.kernel.org>
Subject: knfsd and memory usage
Date: Fri, 7 Dec 2001 11:45:07 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I have this new file server (2.4.16), and it's memory looks like
Mem:    771952K total,   767492K used,     4460K free,    22016K buffers
Swap:        0K total,        0K used,        0K free,    71848K cached

So cache, buffers, and free memory account for ~100MB.
There are a handful of userspace processes taking ~20MB.

Obviously I expect the kernel to take up some memory, but 650 megs?

Is there I way I can find out where all of that memory went?
If knfsd is hoarding (no other box has this much unaccounted for), is 
there a way to tweak it at runtime?  Are there 'safe' things to adjust at 
compile time?

Thanks
	-- Brian
