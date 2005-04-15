Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVDOHLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVDOHLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 03:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVDOHLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 03:11:15 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:36606 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261751AbVDOHLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 03:11:12 -0400
Date: Fri, 15 Apr 2005 00:26:00 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Ted Kremenek <kremenek@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org, Bryan Fulton <bryan@coverity.com>,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] possible missing capability check in ioctl function, drivers/net/cris/eth_v10.c, kernel 2.6.11
Message-ID: <20050415072600.GA45259@gaz.sfgoth.com>
References: <b86e6e6214dbc3ebe14bf1ec472a1202@cs.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86e6e6214dbc3ebe14bf1ec472a1202@cs.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 15 Apr 2005 00:26:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted Kremenek wrote:
> Currently we are looking primarily into the 
> ioctls in drivers/net,

Just as a small aside, a little over five years ago (wow does time fly!) I
did a manual audit for mistakes like this:
  http://lkml.org/lkml/2000/3/7/156
Not sure if that's relevant to your work your not...I'm not sure how you
would can catch most of these errors statistically since a lot of the
dangerous ioctl's were only for a single device.

-Mitch
