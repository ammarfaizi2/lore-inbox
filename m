Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTEWQ5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 12:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbTEWQ5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 12:57:48 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:18066 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S264097AbTEWQ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 12:57:47 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Hugh Dickins <hugh@veritas.com>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [RFC][PATCH] Avoid vmtruncate/mmap-page-fault race
Date: Fri, 23 May 2003 19:10:58 +0200
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>, <hch@infradead.org>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305231713230.1602-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0305231713230.1602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305231910.58743.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 May 2003 18:21, Hugh Dickins wrote:
> Sorry, I miss the point of this patch entirely.  At the moment it just
> looks like an unattractive rearrangement - the code churn akpm advised
> against - with no bearing on that vmtruncate race.  Please correct me.

This is all about supporting cross-host mmap (nice trick, huh?).  Yes, 
somebody should post a detailed rfc on that subject.

Regards,

Daniel
