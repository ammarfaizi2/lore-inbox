Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUC3B5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUC3B5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:57:51 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:58540 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263484AbUC3B5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:57:44 -0500
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20040329162740.0ca8f6d5.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	 <1080606618.6742.89.camel@arrakis>  <20040329162740.0ca8f6d5.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080611797.6742.153.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Mar 2004 17:56:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 16:27, Paul Jackson wrote:
> Matthew wrote (of my recommendation to not use the mask type directly):
> > Is this necessary, or just convenient?
> 
> Technically as you suspect, just convenient, except in the case of the
> mask_of_bit() macro, as you observe.
> 
> I was adhering to the K.I.S.S. school here - just tell the user one
> recommended way of using things, suppressing my engineering urge to
> explain alternatives that had no real advantages.

That's what I figured.  Just looking for a clarification.


> > I think that it wouldn't be terribly ugly to split out the 1 unsigned
> > long special cases (bitmap_and, bitmap_or, etc) with #ifdefs.
> 
> Do you have in mind an ifdef per function, or putting
> several functions inside an ifdef?  If you think it
> looks better - show us the code ;).

I was thinking of having a large ifdef'd section for the one word case. 
I'll run that up and see if it does in fact look any cleaner.


> Here's my cumulative patch of changes that I have gained so far
> from your excellent feedback, and a couple I've noticed:

<diff snipped>

Looks good.  I'll keep chugging along through the patches! :)

-Matt

