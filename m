Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbTBFE2G>; Wed, 5 Feb 2003 23:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbTBFE2G>; Wed, 5 Feb 2003 23:28:06 -0500
Received: from bitmover.com ([192.132.92.2]:62661 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265513AbTBFE2F>;
	Wed, 5 Feb 2003 23:28:05 -0500
Date: Wed, 5 Feb 2003 20:37:37 -0800
From: Larry McVoy <lm@bitmover.com>
To: Ben Collins <bcollins@debian.org>
Cc: Larry McVoy <lm@bitmover.com>, Andrea Arcangeli <andrea@e-mind.com>,
       linux-kernel@vger.kernel.org
Subject: Re: openbkweb-0.0
Message-ID: <20030206043737.GA27374@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ben Collins <bcollins@debian.org>, Larry McVoy <lm@bitmover.com>,
	Andrea Arcangeli <andrea@e-mind.com>, linux-kernel@vger.kernel.org
References: <20030206021029.GW19678@dualathlon.random> <20030206030908.GA26137@work.bitmover.com> <20030206042303.GB523@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206042303.GB523@phunnypharm.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You may want to enable mod_deflate, and then scripts can easily make use
> of gzip compressed data. May not be an end-all, but something to
> consider.

Gzip will give 4:1 what these scripts are doing is more like 1000:1.  
So gzipping the data gets you down to 250:1.  That's still way more
bandwidth, way too much to be acceptable.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
