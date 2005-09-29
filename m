Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVI2SRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVI2SRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVI2SRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:17:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24234
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932348AbVI2SRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:17:18 -0400
Date: Thu, 29 Sep 2005 11:16:47 -0700 (PDT)
Message-Id: <20050929.111647.65068628.davem@davemloft.net>
To: jheffner@psc.edu
Cc: kuznet@ms2.inr.ac.ru, lists@limebrokerage.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org, gautran@mrv.com
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent
 2.4.x/2.6.x kernels
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200509291204.29393.jheffner@psc.edu>
References: <Pine.LNX.4.61.0509281223560.30951@ionlinux.tower-research.com>
	<20050929151729.GA2158@ms2.inr.ac.ru>
	<200509291204.29393.jheffner@psc.edu>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Heffner <jheffner@psc.edu>
Date: Thu, 29 Sep 2005 12:04:28 -0400

> Has anyone looked at the patch I sent out on Sept 9?  It goes a few steps 
> further, addressing some additional problems.  Original message below.

It's in my inbox pending review, so it's not forgotten :-)

My gut instinct right now is that we should put Alexey's
2-liner in for 2.6.14 et al. then be thinking about your
scheme for 2.6.15
