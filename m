Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273727AbRIQWhn>; Mon, 17 Sep 2001 18:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273731AbRIQWh2>; Mon, 17 Sep 2001 18:37:28 -0400
Received: from [194.213.32.137] ([194.213.32.137]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273727AbRIQW3X>;
	Mon, 17 Sep 2001 18:29:23 -0400
Date: Fri, 14 Sep 2001 10:03:51 +0000
From: Pavel Machek <pavel@suse.cz>
To: John Ripley <jripley@riohome.com>
Cc: linux-kernel@vger.kernel.org, VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: COW fs (Re: Editing-in-place of a large file)
Message-ID: <20010914100350.C35@toy.ucw.cz>
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <318476047.20010903002818@port.imtp.ilyichevsk.odessa.ua> <3B9B80E2.C9D5B947@riohome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B9B80E2.C9D5B947@riohome.com>; from jripley@riohome.com on Sun, Sep 09, 2001 at 03:46:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - Keep a hash of the contents of blocks in the buffer-cache.
> - The kernel compares the hash of each block write to all blocks already
> in the buffer-cache.
> - If a duplicate is found, the kernel generates a COW link instead of
> writing the block to disk.
> 
> Obviously this would involve large amounts of CPU. I think a simple

Why? If you hashed the hashes, you could do it very fast.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

