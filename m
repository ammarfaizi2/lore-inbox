Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUE0HSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUE0HSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 03:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUE0HSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 03:18:17 -0400
Received: from mail1.kontent.de ([81.88.34.36]:29871 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261648AbUE0HSQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 03:18:16 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Tom Felker <tcfelker@mtco.com>
Subject: Re: why swap at all?
Date: Thu, 27 May 2004 09:16:47 +0200
User-Agent: KMail/1.6.2
Cc: Matthias Schniedermeyer <ms@citd.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <20040526123740.GA14584@citd.de> <200405270014.10096.tcfelker@mtco.com>
In-Reply-To: <200405270014.10096.tcfelker@mtco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405270916.47868.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 27. Mai 2004 07:14 schrieb Tom Felker:
> Most drastic would be to change the way to choose pages to throw out.  
> Different processes or pages could have different priorities, so you could 
> mark interactive processes as keepers even if you haven't used them in days.

Do you really want that? Wouldn't you rather want pages of such tasks
swapped in very aggresively once the first page fault happens? Or even
preemptively?

	Regards
		Oliver
