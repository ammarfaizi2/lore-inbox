Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276989AbRJHQYg>; Mon, 8 Oct 2001 12:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276978AbRJHQYQ>; Mon, 8 Oct 2001 12:24:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37134 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276981AbRJHQYO>; Mon, 8 Oct 2001 12:24:14 -0400
Subject: Re: [OT] testing internet performance, esp latency/drops?
To: lm@bitmover.com (Larry McVoy)
Date: Mon, 8 Oct 2001 17:30:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011008090203.L26223@work.bitmover.com> from "Larry McVoy" at Oct 08, 2001 09:02:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qdI7-00014B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> about just coding every reference in bookmarks/history into a driver
> file which drove a connect-o-matic program that timed how fast it 
> could connect to each of those sites.  Any comments on that idea?

Try connecting to them by ip number - picking a page that doesn't contain
references to other DNS records. Then find a site or a friend who can put
a site on a port other than 80 or 8080 and see if that is mysteriously 
fast even using DNS.

If its the former then its probably DNS issues. If it goes away with non
port 80 its someones transparent proxy
