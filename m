Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBBXLE>; Fri, 2 Feb 2001 18:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129162AbRBBXKx>; Fri, 2 Feb 2001 18:10:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16520 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129055AbRBBXKn>;
	Fri, 2 Feb 2001 18:10:43 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14971.15897.432460.25166@pizda.ninka.net>
Date: Fri, 2 Feb 2001 15:09:13 -0800 (PST)
To: David Lang <dlang@diginsite.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <Pine.LNX.4.31.0102021456000.1221-100000@dlang.diginsite.com>
In-Reply-To: <14971.14511.765806.838208@pizda.ninka.net>
	<Pine.LNX.4.31.0102021456000.1221-100000@dlang.diginsite.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Lang writes:
 > Thanks, that info on sendfile makes sense for the fileserver situation.
 > for webservers we will have to see (many/most CGI's look at stuff from the
 > client so I still have doubts as to how much use cacheing will be)

Also note that the decreased CPU utilization resulting from
zerocopy sendfile leaves more CPU available for CGI execution.

This was a point I forgot to make.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
