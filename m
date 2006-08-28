Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWH1J5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWH1J5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWH1J5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:57:17 -0400
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:26852 "EHLO
	liaag1ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932488AbWH1J5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:57:17 -0400
Date: Mon, 28 Aug 2006 05:50:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux v2.6.18-rc5
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <200608280554_MC3-1-C993-607@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>

On Sun, 27 Aug 2006 23:14:21 -0700, Andrew Morton wrote:

> > Linux 2.6.18-rc5 is out there now
> 
> (Reporters Bcc'ed: please provide updates)
> 
> Serious-looking regressions include:
> 
> <...>
> 
> From: Chuck Ebbert <76306.1226@compuserve.com>
> Subject: PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0

Also happens on 2.6.16.28 and 2.6.17.11, so not a regression.

> From: "Beschorner Daniel" <Daniel.Beschorner@facton.com>
> Subject: fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.
> 
>   (I think we fixed this?)

Fixed by this -rc5 patch:

        Trond Myklebust:
              fcntl(F_SETSIG) fix

-- 
Chuck
