Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVHTAWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVHTAWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVHTAWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:22:18 -0400
Received: from claven.physics.ucsb.edu ([128.111.16.29]:37542 "EHLO
	claven.physics.ucsb.edu") by vger.kernel.org with ESMTP
	id S932364AbVHTAWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:22:17 -0400
Date: Fri, 19 Aug 2005 17:22:12 -0700 (PDT)
From: Nathan Becker <nbecker@physics.ucsb.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: lost ticks and Hangcheck
In-Reply-To: <20050819094500.GB16279@kurtwerks.com>
Message-ID: <Pine.LNX.4.63.0508191714150.8252@claven.physics.ucsb.edu>
References: <Pine.LNX.4.63.0508182351460.6338@claven.physics.ucsb.edu>
 <20050819094500.GB16279@kurtwerks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I use the no_timer_check kernel parm and that keeps the clock from
> running at double speed. I still see some other annoying boot-time

As I mentioned, no_timer_check doesn't fix it for me.  In fact it makes 
the problem significantly worse.  I tried it again just to be sure.  Also 
I tried noapic again and it doesn't help either.

I found there was an upgrade to the NVIDIA graphics driver that addressed 
a clock issue (I don't know if it's related to my problem).  I upgraded 
from version 7667 to 7676.  That seemed to help a little bit, at least in 
prolonging the amount of time I could reasonably use the system.  Someone 
in another thread mentioned that they thought this problem might be caused 
by something in x.org, which I am using.

Any other ideas or patches would be much appreciated.

thanks for your help,

Nathan
