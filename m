Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752008AbWISTqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbWISTqi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbWISTqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:46:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752004AbWISTqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:46:36 -0400
Date: Tue, 19 Sep 2006 12:44:42 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: dlang@digitalinsight.com, kuznet@ms2.inr.ac.ru, master@sectorb.msk.ru,
       ak@suse.de, hawk@diku.dk, harry@atmos.washington.edu,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060919124442.0b1127c0@localhost.localdomain>
In-Reply-To: <20060919.124034.78165098.davem@davemloft.net>
References: <20060918211759.GB31746@tentacle.sectorb.msk.ru>
	<20060918220038.GB14322@ms2.inr.ac.ru>
	<Pine.LNX.4.63.0609181452470.14338@qynat.qvtvafvgr.pbz>
	<20060919.124034.78165098.davem@davemloft.net>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sky2 hardware (and others) can timestamp in hardware, but trying
to keep device ticks and system clock in sync looked too nasty
to contemplate actually using it.
