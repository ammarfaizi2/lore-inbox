Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263704AbTDTVO1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTDTVO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:14:26 -0400
Received: from hera.cwi.nl ([192.16.191.8]:48599 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263704AbTDTVOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:14:24 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 23:26:24 +0200 (MEST)
Message-Id: <UTC200304202126.h3KLQO623927.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, davem@redhat.com
Subject: Re: [PATCH] new system call mknod64
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From davem@redhat.com  Sun Apr 20 23:12:17 2003

    > Yesterday or the day before Linus preferred __u32 etc for this
    > loopinfo64 ioctl, so I did it that way. Here, since mknod is a
    > traditional Unix system call, I am still inclined to prefer
    > (unsigned) int above __u32.  Of course it doesn't matter much.

    To 64-bit platforms implementing 32-bit compatability layers,
    it can matter a ton to use portable vs. non-portable types.

Such an abstract statement nobody can disagree with.
Do you have an opinion in the mknod case?

(For example, I do not suppose anybody would argue that
open() should return an __u32 instead of an int.)

Andries
