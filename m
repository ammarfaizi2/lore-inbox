Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbSJVSxx>; Tue, 22 Oct 2002 14:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSJVSxw>; Tue, 22 Oct 2002 14:53:52 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:41070 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261784AbSJVSxu>;
	Tue, 22 Oct 2002 14:53:50 -0400
Date: Tue, 22 Oct 2002 20:59:58 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christoph Hellwig <hch@infradead.org>,
       Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021022185958.GB26585@win.tue.nl>
References: <20021022161957.N26402@fi.muni.cz> <20021022184034.GA26585@win.tue.nl> <20021022194514.B3867@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021022194514.B3867@infradead.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 07:45:14PM +0100, Christoph Hellwig wrote:

> Andries, have you actually CHECKED whether he has it enabled?

No.  I do not claim that his problem was caused by the stats.
It is just that I get reports from people with mysterious mount
and fdisk problems that go away when CONFIG_BLK_STATS is disabled.
And requests from RedHat to put ugly patches into mount to
tell stdio to use a larger buffer, increasing the probability that
all is read in one go.


> I rather suspect it's the following bug (introduce by me, but not
> depend on CONFIG_BLK_STATS):

Good!

So the very reproducible problem is solved, and only the
sporadic random problem is left.

I still hope that you will remove it again.

Andries

