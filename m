Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269581AbUI3WBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269581AbUI3WBb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269535AbUI3WBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:01:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:46782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269582AbUI3WAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:00:50 -0400
Date: Thu, 30 Sep 2004 15:00:46 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Judith Lebzelter <judith@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: OSDL aio-stress results on latest kernels show buffered random
 read issue
In-Reply-To: <20040930004447.GI9106@holomorphy.com>
Message-ID: <Pine.LNX.4.33.0409301412340.4332-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, William Lee Irwin III wrote:

> On Wed, Sep 29, 2004 at 04:29:08PM -0700, Judith Lebzelter wrote:
> > There seems to be an issue with the reads.  Usually, reads
> > should be at least as fast as writes of the same type.
> > Also, there seems to be a substantial drop-off in the performance
> > of AIO buffered-random writes in the mm kernels. (14% on 2CPU,
> > 40% on 4CPU)
>
> Okay, is it cpu time or idle/iowait? If it's cpu time, where do
> profiles show it appears?

Th CPU is not that busy:

2.6.9-rc2-mm4 Results and iostat outputs:
http://khack.osdl.org/stp/297714/
http://khack.osdl.org/stp/297714/results/bufferrand/iostat.txt

2.6.9-rc2 Results and iostat outputs:
http://khack.osdl.org/stp/297545/
http://khack.osdl.org/stp/297545/results/bufferrand/iostat.txt


The iostat has the write stats followed by the reads, taken every 15
seconds.

>
>
> -- wli
>

