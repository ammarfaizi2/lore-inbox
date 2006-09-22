Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWIVEiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWIVEiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 00:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbWIVEiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 00:38:05 -0400
Received: from solarneutrino.net ([66.199.224.43]:17157 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751698AbWIVEiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 00:38:03 -0400
Date: Fri, 22 Sep 2006 00:38:01 -0400
To: Stephen Olander Waters <swaters@luy.info>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: R200 lockup (was Re: DRI/X error resolution)
Message-ID: <20060922043801.GE16939@tau.solarneutrino.net>
References: <1158898988.3280.8.camel@ix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1158898988.3280.8.camel@ix>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 11:23:08PM -0500, Stephen Olander Waters wrote:
> Hey,
> 
> Did they ever fix that bug you reported here?
> http://lkml.org/lkml/2005/5/11/121
> 
> I'm having the same problem! Argh!

No, sad to say it still happens to us too.  Argh is right!

I'll cc this to dri-devel and lkml in case anyone wants to try hunting
the bug again.

FWIW, I'm still seeing the ioctl(5, 0x6444, 0) / SIGALARM behavior I
reported originally.  This has continued to happen regularly with all
2.6 kernels up to 2.6.17.6 and Xfree/X.org up to 6.9.

-ryan
