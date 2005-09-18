Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVIRLHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVIRLHD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 07:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVIRLHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 07:07:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61369 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751163AbVIRLHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 07:07:01 -0400
Date: Sun, 18 Sep 2005 12:06:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050918110658.GA22744@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432AFB44.9060707@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I threw in your new codedrop into a compilation and the byte-order
mess is _still_ now sorted out.  Please kill the d* as struct type
crap and just use __le types directly.

Also lots of "memset with byte count of 0" warnings from sparse.
