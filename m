Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTDDOsf (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTDDOn3 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:43:29 -0500
Received: from [61.11.16.46] ([61.11.16.46]:15372 "EHLO mailpune.cygnet.co.in")
	by vger.kernel.org with ESMTP id S263711AbTDDO3w (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 09:29:52 -0500
Subject: Re: Strange e1000
From: Abhishek Agrawal <abhishek@abhishek.agrawal.name>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <043501c2faaf$da061e10$3f00a8c0@witbe>
References: <043501c2faaf$da061e10$3f00a8c0@witbe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Date: 04 Apr 2003 19:49:28 +0530
Message-Id: <1049465969.3324.40.camel@abhilinux.cygnet.co.in>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-04 at 19:11, Paul Rolland wrote:

> Could it be possible that the 1000MBps FD on the e1000 side is
> a local configuration, and that it needs some time to discuss with
> the Netgear switch to negotiate correctly speed and duplex before
> working correctly ? (i.e. 20 sec = negotiation time)
Autoneg must be completed within 2 sec, or else it is considered as
failed.

