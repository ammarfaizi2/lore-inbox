Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267144AbUBMSWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267152AbUBMSWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:22:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:63711 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267144AbUBMSWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:22:32 -0500
Date: Fri, 13 Feb 2004 10:22:30 -0800
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: why are capabilities disabled?
Message-ID: <20040213102230.B14506@build.pdx.osdl.net>
References: <c0iqrq$erh$1@sea.gmane.org> <200402131601.i1DG1Nsl020006@turing-police.cc.vt.edu> <402D0F6D.7090803@upb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <402D0F6D.7090803@upb.de>; from skoehler@upb.de on Fri, Feb 13, 2004 at 06:54:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Köhler (skoehler@upb.de) wrote:
> >>"getpcaps 1" shows, that the init-process is started without 
> >>cap_setpcap, and i know that i can change that somehow.
> >>So why are capabilities disabled? and how do i enable them?

Oh, I see.  Not having cap_setpcap does not mean capabilities are
disabled.  It's the standard set.

> i found the hint again: i have to change the value CAP_INIT_EFF_SET in 
> capability.h, so that init-process is not started with disabled 
> cap_setpcap, but is this still a security risk?

Yes.  Don't do that.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
