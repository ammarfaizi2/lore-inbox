Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVANVYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVANVYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVANVGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:06:41 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:64229 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262169AbVANVE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:04:56 -0500
Date: Fri, 14 Jan 2005 13:04:38 -0800
From: Dave Jiang <dave.jiang@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux@arm.linux.org.uk, smaurer@teja.com,
       dsaxena@plexity.net, mporter@kernel.crashing.org,
       drew.moseley@intel.com
Subject: Re: [PATCH 1/5] resource: core changes to update u64 to unsigned long
Message-ID: <20050114210438.GA21248@plexity.net>
Reply-To: dave.jiang@gmail.com
References: <20050114200103.GA19386@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114200103.GA19386@plexity.net>
Organization: Intel Corp.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14 2005, at 12:01, Dave Jiang was caught saying:
> Here's the rework per Andrew and others' comments. Attempt to change
> resource.start and resource.end to u64 from unsigned long.
> 
> Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
> 

Oops, I left out the part where Andrew suggested to cast the vars in
printk to (unsigned long long). I will put out applicable patches with
those updates. Sorry about that.....
