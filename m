Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbTIIB6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 21:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTIIB6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 21:58:25 -0400
Received: from hera.cwi.nl ([192.16.191.8]:60625 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263602AbTIIB6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 21:58:24 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 9 Sep 2003 03:58:21 +0200 (MEST)
Message-Id: <UTC200309090158.h891wLf25425.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, torvalds@osdl.org
Subject: sparse
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the rest are mostly due to the address space checks. Some of them are
> likely trivial to fix, but the most interesting ones (in the networking
> code) are because the networking code re-uses the same data structures
> for both kernel and user addresses.

By separate mail I sent you half a dozen or perhaps a dozen sparse
fixes, all of the trivial kind. Hope you don't mind.
I did more, but the nfs / aio / sendfile stuff involves somewhat
larger surgery - will send some other time.

> it's not seriously usable yet

I like it, or, rather, the result of having __user annotation
for pointers to user space.

Andries
