Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbUJYQjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUJYQjG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUJYQgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:36:35 -0400
Received: from mxsf20.cluster1.charter.net ([209.225.28.220]:25785 "EHLO
	mxsf20.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262072AbUJYQbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:31:23 -0400
X-Ironport-AV: i="3.86,98,1096862400"; 
   d="scan'208"; a="362017117:sNHT20344188"
Date: Mon, 25 Oct 2004 12:31:21 -0400
From: misty-@charter.net
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-ck1: swap mayhem under UT2004
Message-ID: <20041025163121.GA3603@roll>
References: <200410222346.32823.alastair@altruxsolutions.co.uk> <200410231722.59362.alastair@altruxsolutions.co.uk> <417B1A7F.2020607@yahoo.com.au> <200410241138.55618.alastair@altruxsolutions.co.uk> <417BA006.3030305@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417BA006.3030305@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to say that your patch fixes a similar slideshow problem I was
having with RTCW - same symptoms, apparently same solution. Applying your
patch kept kswapd from using 90-100% cpu in top whenever I was running the
game on my 512MB ram system running stock 2.6.9.

Thanks a bunch,
Tim McGrath
