Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUJHBxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUJHBxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUJHBxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 21:53:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:46826 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269846AbUJHBvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 21:51:37 -0400
Date: Thu, 7 Oct 2004 18:51:31 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-ID: <20041007185131.T2357@build.pdx.osdl.net>
References: <20041007142019.D2441@build.pdx.osdl.net> <20041007164044.23bac609.akpm@osdl.org> <4165E0A7.7080305@yahoo.com.au> <20041007174242.3dd6facd.akpm@osdl.org> <20041007184134.S2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041007184134.S2357@build.pdx.osdl.net>; from chrisw@osdl.org on Thu, Oct 07, 2004 at 06:41:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > 
> > OK, after backing out the `goto spaghetti;' patch and cleaning up a few
> > thing I'll test the below.  It'll make kswapd much less aggressive.
> 
> testing with this compile fix:

passes initial simple testing (whereas I could get the mainline code, and the
one-liner to spin right off).  

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
