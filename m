Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbSKZUK2>; Tue, 26 Nov 2002 15:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266754AbSKZUK1>; Tue, 26 Nov 2002 15:10:27 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:38534 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266708AbSKZUK0>;
	Tue, 26 Nov 2002 15:10:26 -0500
Subject: Re: [RFC] [PATCH] linux-2.5.49_subarch-cleanup_A2
From: john stultz <johnstul@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: James.Bottomley@HansenPartnership.com,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Russell King <rmk@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20021126195427.GB1525@mars.ravnborg.org>
References: <1038274857.959.10.camel@w-jstultz2.beaverton.ibm.com>
	 <20021126195427.GB1525@mars.ravnborg.org>
Content-Type: text/plain
Organization: 
Message-Id: <1038341769.956.49.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 26 Nov 2002 12:16:09 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 11:54, Sam Ravnborg wrote:
> One detail..
> Move the "mcore-y := mach-default" assignment above the
> block that deal with subarch. Then you do not need the "ifndef ..."

Ah, good suggestion! Thanks! I'll apply and resubmit later today.

> I recall that Linus previously have asked for shell commands
> when moving files - so consider including only the patch below and
> then a number of "mv arch/i386/X include/....".
> This makes it much more visible what you actually change.
> 
> Another alternative it to do it in bitkeeper, then it is visible
> from the cset that you move files (use bk mv).

Hmm. I was under the impression that shell command and sed script
patches were only for those w/ enough kernel penguin points to blow.
Although, please someone correct me if I'm wrong.  Regardless BK should
notice the renames in the diff and import them as such, so it shouldn't
make much difference to Linus. 

Thanks again for the feedback!

-john

