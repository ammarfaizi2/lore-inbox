Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbUC3Ton (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbUC3Ton
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:44:43 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:45074 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263874AbUC3Tol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:44:41 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2
Date: Tue, 30 Mar 2004 11:44:26 -0800
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040317201454.5b2e8a3c.akpm@osdl.org> <200403301127.05151.jbarnes@sgi.com> <20040330113620.33d01d9c.akpm@osdl.org>
In-Reply-To: <20040330113620.33d01d9c.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403301144.26050.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2004 11:36 am, Andrew Morton wrote:
> I don't see anything especially hangy in 2.6.5-rc1-mm2 - maybe it's
> something which was sucked in via one of the "external trees".  rc3-mm1
> boots OK on my ia64 box.

Well, like I said, the BK trees (both Linus' linux-2.5 and David's 
to-linus-2.5) continue to work, all the way up through today, and 
2.6.5-rc1-mm1 worked too.

> Do you not have the means to work out where things are stuck at?

It looks like there's a bug in the sysrq implementation in the sn_serial 
driver.  Once the initial console is opened, sysrq no longer works.  All I've 
determined so far is that both CPUs in my box are in cpu_idle somewhere...  
Anyway, I'll keep looking.

Thanks,
Jesse
