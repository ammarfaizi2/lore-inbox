Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWC3X2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWC3X2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 18:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWC3X2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 18:28:07 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60311
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751147AbWC3X2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 18:28:06 -0500
Date: Thu, 30 Mar 2006 15:28:21 -0800 (PST)
Message-Id: <20060330.152821.24959319.davem@davemloft.net>
To: adrian@smop.co.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: 2.6.16-mm1 leaks in dvb playback (found)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060330231131.GA25029@smop.co.uk>
References: <20060330004518.GA23404@smop.co.uk>
	<20060330225830.GA24009@smop.co.uk>
	<20060330231131.GA25029@smop.co.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bridgett <adrian@smop.co.uk>
Date: Fri, 31 Mar 2006 00:11:31 +0100

> On Thu, Mar 30, 2006 at 23:58:30 +0100 (+0100), adrian wrote:
> > What I thought was just one patch was actually two and it was the
> > other patch causing the problem - "Do not lose accepted socket when
> > -ENFILE/-EMFILE".
> 
> Hmm - it looks like it was meant to be reverted in 2.6.16-rc1-mm4,5 FWIW.

So is the current version in Linus's tree causing this problem?

Yes, in the middle while initially doing development on that patch
there were many bad leaks, but later on those were all fixed.
