Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTF0PFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTF0PCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:02:14 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:13740 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S264542AbTF0PBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 11:01:47 -0400
From: Daniel Phillips <phillips@arcor.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] My research agenda for 2.7
Date: Fri, 27 Jun 2003 17:17:01 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306271654.46491.phillips@arcor.de> <25700000.1056726277@[10.10.2.4]>
In-Reply-To: <25700000.1056726277@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306271717.01562.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 June 2003 17:04, Martin J. Bligh wrote:
> Daniel Phillips <phillips@arcor.de> wrote (on Friday, June 27, 2003
> > Some allocation strategies may be statistically more
> > resistiant to fragmentation than others, but no allocator has been
> > invented, or ever will be, that can guarantee that terminal fragmentation
> > will never occur - only active defragmentation can provide such a
> > guarantee.
>
> Whilst I agree with that in principle, it's inevitably expensive. Thus
> whilst we may need to have that code, we should try to avoid using it ;-)

That's exactly the idea.  Active defragmentation is just a fallback to handle  
currently-unhandled corner cases.  A good, efficient allocator that resists 
fragmentation in the first place is still needed.

Regards,

Daniel

