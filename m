Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWH1Vsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWH1Vsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWH1Vsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:48:54 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:2962 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932202AbWH1Vsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:48:52 -0400
Subject: Re: Reiser4 und LZO compression
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Edward Shishkin <edward@namesys.com>
Cc: Stefan Traby <stefan@hello-penguin.com>, Hans Reiser <reiser@namesys.com>,
       Alexey Dobriyan <adobriyan@gmail.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44F332D6.6040209@namesys.com>
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>
	 <44F322A6.9020200@namesys.com> <20060828173721.GA11332@hello-penguin.com>
	 <44F332D6.6040209@namesys.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 07:48:25 +1000
Message-Id: <1156801705.2969.6.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-08-28 at 22:15 +0400, Edward Shishkin wrote:
> Stefan Traby wrote:
> > On Mon, Aug 28, 2006 at 10:06:46AM -0700, Hans Reiser wrote:
> > 
> > 
> >>Hmm.  LZO is the best compression algorithm for the task as measured by
> >>the objectives of good compression effectiveness while still having very
> >>low CPU usage (the best of those written and GPL'd, there is a slightly
> >>better one which is proprietary and uses more CPU, LZRW if I remember
> >>right.  The gzip code base uses too much CPU, though I think Edward made
> > 
> > 
> > I don't think that LZO beats LZF in both speed and compression ratio.
> > 
> > LZF is also available under GPL (dual-licensed BSD) and was choosen in favor
> > of LZO for the next generation suspend-to-disk code of the Linux kernel.
> > 
> > see: http://www.goof.com/pcg/marc/liblzf.html
> > 
> 
> thanks for the info, we will compare them

For Suspend2, we ended up converting the LZF support to a cryptoapi
plugin. Is there any chance that you could use cryptoapi modules? We
could then have a hope of sharing the support.

Regards,

Nigel

