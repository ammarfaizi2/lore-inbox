Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVCJCaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVCJCaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVCJC1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:27:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:51927 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261158AbVCJC0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:26:21 -0500
Date: Wed, 9 Mar 2005 18:25:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Direct io on block device has performance regression on 2.6.x
 kernel
Message-Id: <20050309182550.0291c6fd.akpm@osdl.org>
In-Reply-To: <200503091721.j29HLNg24054@unix-os.sc.intel.com>
References: <20050308222737.3712611b.akpm@osdl.org>
	<200503091721.j29HLNg24054@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> This is all real: real benchmark running on real hardware, with real
>  result showing large performance regression.  Nothing synthetic here.
> 

Ken, could you *please* be more complete, more organized and more specific?

What does "1/3 of the total benchmark performance regression" mean?  One
third of 0.1% isn't very impressive.  You haven't told us anything at all
about the magnitude of this regression.

Where does the rest of the regression come from?

How much system time?  User time?  All that stuff.

>  And yes, it is all worth pursuing, the two patches on raw device recuperate
>  1/3 of the total benchmark performance regression.

The patch needs a fair bit of work, and if it still provides useful gains
when it's complete I guess could make sense as some database special-case.

But the first thing to do is to work out where the cycles are going to.


Also, I'm rather peeved that we're hearing about this regression now rather
than two years ago.  And mystified as to why yours is the only group which
has reported it.
