Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUDPXfK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbUDPXfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:35:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:42376 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263939AbUDPXfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:35:04 -0400
Date: Fri, 16 Apr 2004 16:35:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: module_param() doesn't seem to work in 2.6.6-rc1
Message-ID: <20040416163501.E22989@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0404161735560.5025@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0404161735560.5025@marabou.research.att.com>; from proski@gnu.org on Fri, Apr 16, 2004 at 06:24:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Roskin (proski@gnu.org) wrote:
> A bigger problem is that the new parameters cannot be used on the modprobe
> command line.  I added this to orinoco.c:
> 
> static int parmtest1, parmtest2;
> MODULE_PARM(parmtest1, "i");
> module_param(parmtest2, int, 644);

You can not mix the use of the two.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
