Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWH1Rhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWH1Rhf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWH1Rhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:37:35 -0400
Received: from 85-126-92-14.work.xdsl-line.inode.at ([85.126.92.14]:9708 "EHLO
	kotzmaster") by vger.kernel.org with ESMTP id S1750805AbWH1Rhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:37:35 -0400
Date: Mon, 28 Aug 2006 19:37:21 +0200
From: Stefan Traby <stefan@hello-penguin.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Reiser4 und LZO compression
Message-ID: <20060828173721.GA11332@hello-penguin.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
References: <20060827003426.GB5204@martell.zuzino.mipt.ru> <44F322A6.9020200@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F322A6.9020200@namesys.com>
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.6.16.20-km (i686)
X-PGP: Key fingerprint = C090 8941 DAD8 4B09 77B1  E284 7873 9310 3BDB EA79 
X-MIL: A-6172171143
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 10:06:46AM -0700, Hans Reiser wrote:

> Hmm.  LZO is the best compression algorithm for the task as measured by
> the objectives of good compression effectiveness while still having very
> low CPU usage (the best of those written and GPL'd, there is a slightly
> better one which is proprietary and uses more CPU, LZRW if I remember
> right.  The gzip code base uses too much CPU, though I think Edward made

I don't think that LZO beats LZF in both speed and compression ratio.

LZF is also available under GPL (dual-licensed BSD) and was choosen in favor
of LZO for the next generation suspend-to-disk code of the Linux kernel.

see: http://www.goof.com/pcg/marc/liblzf.html

-- 

  ciao - 
    Stefan
