Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWH1SQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWH1SQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWH1SQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:16:06 -0400
Received: from mail.zelnet.ru ([80.92.97.13]:21942 "EHLO mail.zelnet.ru")
	by vger.kernel.org with ESMTP id S1750795AbWH1SQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:16:03 -0400
Message-ID: <44F332D6.6040209@namesys.com>
Date: Mon, 28 Aug 2006 22:15:50 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Stefan Traby <stefan@hello-penguin.com>
CC: Hans Reiser <reiser@namesys.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Reiser4 und LZO compression
References: <20060827003426.GB5204@martell.zuzino.mipt.ru> <44F322A6.9020200@namesys.com> <20060828173721.GA11332@hello-penguin.com>
In-Reply-To: <20060828173721.GA11332@hello-penguin.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Traby wrote:
> On Mon, Aug 28, 2006 at 10:06:46AM -0700, Hans Reiser wrote:
> 
> 
>>Hmm.  LZO is the best compression algorithm for the task as measured by
>>the objectives of good compression effectiveness while still having very
>>low CPU usage (the best of those written and GPL'd, there is a slightly
>>better one which is proprietary and uses more CPU, LZRW if I remember
>>right.  The gzip code base uses too much CPU, though I think Edward made
> 
> 
> I don't think that LZO beats LZF in both speed and compression ratio.
> 
> LZF is also available under GPL (dual-licensed BSD) and was choosen in favor
> of LZO for the next generation suspend-to-disk code of the Linux kernel.
> 
> see: http://www.goof.com/pcg/marc/liblzf.html
> 

thanks for the info, we will compare them
