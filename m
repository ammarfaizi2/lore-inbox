Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbUABS3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 13:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbUABS3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 13:29:24 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:62735 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265553AbUABS3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 13:29:23 -0500
Date: Fri, 2 Jan 2004 18:29:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Claas Langbehn <claas@rootdir.de>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS forced shutdown with kernel 2.6.0
Message-ID: <20040102182921.A27237@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Claas Langbehn <claas@rootdir.de>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <20040102095051.GA19872@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040102095051.GA19872@rootdir.de>; from claas@rootdir.de on Fri, Jan 02, 2004 at 10:50:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 10:50:51AM +0100, Claas Langbehn wrote:
> Hello!
> 
> 
> Last night one of my machines running xfs shut down my /homes partition.
> 
> That machine was running Azureus (a bittorrent client) with probably
> high memory usage.
> 
> But even if the memory usage of one program is going near to 100% it
> should not force the filesystem to shutdown. Instead it should crash
> the application.
> 
> I could also think of bad memory, but we did test the SDRAM modules
> only a week ago, and they passed memtest86.
> 
> After rebooting everything was working fine, again.
> 
> So, is this a bug of xfs?

I've seen the same bug a few times lately, but only if I had previous
memory corruption due to code I was hacking on.  Can you reproduce it
without the nvidia module loaded as that is likely source of such
corruption?

