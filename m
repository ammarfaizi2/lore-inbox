Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132819AbQLHVHV>; Fri, 8 Dec 2000 16:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132834AbQLHVHL>; Fri, 8 Dec 2000 16:07:11 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:14436 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132819AbQLHVHG>; Fri, 8 Dec 2000 16:07:06 -0500
Date: Fri, 8 Dec 2000 15:36:35 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
In-Reply-To: <20001208212910.E599@jaquet.dk>
Message-ID: <Pine.LNX.4.10.10012081534290.11892-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patch moves the page_table_lock in mm/* to cover the
> modification of mm->rss in 240-test12-pre7. It was inspired by a 

can't we just change rss to count pages? 
or are we worried about rss's over ~16 TB?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
