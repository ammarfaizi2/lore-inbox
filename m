Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318869AbSH1PGW>; Wed, 28 Aug 2002 11:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318870AbSH1PGW>; Wed, 28 Aug 2002 11:06:22 -0400
Received: from bitmover.com ([192.132.92.2]:39569 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S318869AbSH1PGV>;
	Wed, 28 Aug 2002 11:06:21 -0400
Date: Wed, 28 Aug 2002 08:10:36 -0700
From: Larry McVoy <lm@bitmover.com>
To: Paul Larson <plars@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, scott.feldman@intel.com
Subject: Re: LTP Nightly BK Test Failure
Message-ID: <20020828081036.B28927@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Paul Larson <plars@austin.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, scott.feldman@intel.com
References: <1030545604.2601.3.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030545604.2601.3.camel@plars.austin.ibm.com>; from plars@austin.ibm.com on Wed, Aug 28, 2002 at 09:40:03AM -0500
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 09:40:03AM -0500, Paul Larson wrote:
> This bk tree covered up to cset 1.523.1.3 and there were several e100

Because revisions in BK change if there is parallel development, it's
far more effective if you list a changeset as either

	bk changes -r1.523.1.3
i.e.,
	ChangeSet@1.523.1.3, 2002-08-27 18:29:55-07:00, fdavis@si.rr.com
	  [PATCH] drivers/media/video/bt819.c
	    
	  Here's the bt819 i2c-old --> i2c patch.

or as the revision and the key, 
	
	bk prs -hr1.523.1.3 -nd':I: (:KEY:)'
i.e.,
	1.523.1.3 (fdavis@si.rr.com|ChangeSet|20020828012955|42356)

You can use the key any place you can use the revision, like so

	bk changes -r'fdavis@si.rr.com|ChangeSet|20020828012955|42356'
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
