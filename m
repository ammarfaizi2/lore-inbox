Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265620AbUBGAUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbUBGAUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:20:22 -0500
Received: from mail.shareable.org ([81.29.64.88]:19920 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265620AbUBGAUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:20:18 -0500
Date: Sat, 7 Feb 2004 00:20:10 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Valdis.Kletnieks@vt.edu
Cc: the grugq <grugq@hcunix.net>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040207002010.GF12503@mail.shareable.org>
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402040320.i143KCaD005184@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> Actually, I have encountered file systems where two successive
> write() calls from userspace to the same offset in the file wouldn't
> end up in the same physical location on the disk (AIX's JFS with compression).

See also:

    - ext3 with data journalling

    - reiser4 with wandering logs

    - experimental ext? patches for tail-packing small files

-- Jamie
