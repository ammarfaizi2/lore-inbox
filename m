Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUCFVBE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 16:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbUCFVBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 16:01:04 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:30352 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261711AbUCFVBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 16:01:00 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ANNOUCE: OpenIB InfiniBand software
References: <52znavp2mk.fsf@topspin.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 06 Mar 2004 13:00:59 -0800
In-Reply-To: <52znavp2mk.fsf@topspin.com>
Message-ID: <52brn9wv04.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Mar 2004 21:00:59.0763 (UTC) FILETIME=[20876430:01C403BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several people have requested that we split the possibly-encumbered
SDP code into a separate package so that they don't have to download
it to get the free code.  To allow that, I have split the kernel code
into two packages:

    infiniband-kernel-2004-03-05.tar.bz2
    infiniband-kernel-sdp-2004-03-05.tar.bz2

If you wish to build SDP, you will need to download both packages and
move the SDP files into the appropriate place in the tree.  For all
other protocols, only the first package (containing only pure dual
GPL/BSD code) is required.

The new snapshot is available now from <http://openib.org/downloads>.
(It also contains a few fixes and code cleanups as compared to the
2004-02-26 drop)

