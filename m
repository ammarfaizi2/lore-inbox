Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTF0Ojd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTF0Ojd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:39:33 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:28308 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S264393AbTF0Ojc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:39:32 -0400
From: Daniel Phillips <phillips@arcor.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] My research agenda for 2.7
Date: Fri, 27 Jun 2003 16:54:46 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <Pine.LNX.4.53.0306271345330.14677@skynet> <23430000.1056725030@[10.10.2.4]>
In-Reply-To: <23430000.1056725030@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306271654.46491.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 June 2003 16:43, Martin J. Bligh wrote:
> The buddy allocator is not a good system for getting rid of fragmentation.

We've talked in the past about throwing out the buddy allocator and adopting 
something more modern and efficient and I hope somebody will actually get 
around to doing that.  In any event, defragging is an orthogonal issue.  Some 
allocation strategies may be statistically more resistiant to fragmentation 
than others, but no allocator has been invented, or ever will be, that can 
guarantee that terminal fragmentation will never occur - only active 
defragmentation can provide such a guarantee.

Regards,

Daniel

