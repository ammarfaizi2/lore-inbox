Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131978AbRARHGB>; Thu, 18 Jan 2001 02:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132286AbRARHFn>; Thu, 18 Jan 2001 02:05:43 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:61444
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id <S131978AbRARHF3>; Thu, 18 Jan 2001 02:05:29 -0500
Date: Thu, 18 Jan 2001 02:05:28 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: Documenting stat(2)
Message-ID: <20010118020528.A16871@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9463fj$gsq$1@penguin.transmeta.com> you write:
> Basically, the _only_ think you should depend on is that st_size
> contains:
>  - for regular files, the size of the file in bytes
>  - for symlinks, the length of the symlink.

I don't think this is right - for a symlink, stat should return the
size of the file; lstat should return the size of the symlink.

-- 
David M. Meyer
dmeyer@dmeyer.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
