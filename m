Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVEDSWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVEDSWB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVEDSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:21:51 -0400
Received: from waste.org ([216.27.176.166]:55188 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261311AbVEDSSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:18:08 -0400
Date: Wed, 4 May 2005 11:18:02 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Mercurial v0.4d
Message-ID: <20050504181802.GS22038@waste.org>
References: <20050504025852.GK22038@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504025852.GK22038@waste.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new version of Mercurial is available at:
 
  http://selenic.com/mercurial/

This fixes a handful of bugs reported last night, most notably failing
to pull from the http repo. This turned out to be a failure to quote
'%' characters. Thanks to everyone for their feedback.
 
Once you've got the new version installed, to pull the repo:

  hg init
  hg merge http://selenic.com/hg
  hg checkout    # 'hg co' works too

The web protocol is painfully slow, mostly because it makes an http
round trip per file revision to pull. I'm about to start working on a
replacement that minimizes round trips.

-- 
Mathematics is the supreme nostalgia of our time.
