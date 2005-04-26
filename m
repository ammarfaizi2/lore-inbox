Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVDZRjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVDZRjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDZRgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:36:32 -0400
Received: from peabody.ximian.com ([130.57.169.10]:8597 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261718AbVDZRgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:36:03 -0400
Subject: Re: preempt-count oddities - still looking for comments :)
From: Robert Love <rml@novell.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kpreempt-tech@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.62.0504261929230.2071@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504232254050.2474@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.62.0504261929230.2071@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:35:37 -0400
Message-Id: <1114536937.6851.1.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 19:31 +0200, Jesper Juhl wrote:
> Replying to myself here since the initial mail got no response. Here's 
> hoping that it showing up on the list again draws some comments :-)

I didn't think it was that big of a deal.  ;-)

It seems the right approach.  Personally, I would of made the type an
s32, since fixed-sizes seems to be sensible in the thread_info
structure, but an int is the same thing.  Cool with me.

Acked-by: Robert Love <rml@novell.com>

	Robert Love


