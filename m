Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVADVMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVADVMf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVADVKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:10:16 -0500
Received: from verein.lst.de ([213.95.11.210]:25016 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261869AbVADVIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:08:24 -0500
Date: Tue, 4 Jan 2005 22:08:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
Message-ID: <20050104210812.GA16420@lst.de>
References: <20050102200032.GA8623@lst.de> <1104870292.8346.24.camel@krustophenia.net> <Pine.LNX.4.58.0501041303190.2294@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501041303190.2294@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 01:05:29PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 4 Jan 2005, Lee Revell wrote:
> > 
> > And I posted this to LKML almost a week ago, and a real fix was posted
> > in response.
> > 
> > http://lkml.org/lkml/2004/12/28/112
> 
> Well, I realize that it has been on bugtraq, but does that make it a real 
> concern? I'll make the tristate a boolean, but has anybody half-way sane 
> ever _done_ what is described by the bugtraq posting? IOW, it looks pretty 
> much like a made-up example, also known as a "don't do that then" kind of 
> buglet ;)

I don't think this particular one is too serious.  But I think we'll see
more serious issues with other modular security modules.

The security modules aren't really as isolated as all the driver modules
we have as they're deeply interwinded with the process/file/etc state.
