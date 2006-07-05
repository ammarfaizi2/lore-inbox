Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWGEAya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWGEAya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 20:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWGEAya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 20:54:30 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:30222 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S932356AbWGEAy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 20:54:29 -0400
Date: Wed, 5 Jul 2006 10:55:41 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: possible dos / wsize affected frozen connection length (was: Re: 2.6.17.1: fails to fully get webpage)
Message-ID: <20060705005540.GL2344@zip.com.au>
References: <20060629015915.GH2149@zip.com.au> <20060628.194627.74748190.davem@davemloft.net> <20060629030923.GI2149@zip.com.au> <20060628.204709.41634813.davem@davemloft.net> <20060629041827.GJ2149@zip.com.au> <44A3E898.1020202@tmr.com> <20060629225039.GO2149@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629225039.GO2149@zip.com.au>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 08:50:39AM +1000, CaT wrote:
> Another datapoint to this is that I've had this my netcat web test
> running since 8:42pm yesterday. It's 8:37am now. It hasn't progressed
> in any way. It hasn't quit. It hasn't timed out. It just sits there,
> hung. This leads me to consider the possibility of a DOS, either
> intentional or accidental (think about 2.6.17.x running on a mail server
> and someone mails/spams from a broken place).

I'm just wondering if connections hanging around this long are normal.
The above has now been running for 6 days. netstat is still reporting an
established session. netcat has not timed out. It's all just sitting
there doing nothing.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
