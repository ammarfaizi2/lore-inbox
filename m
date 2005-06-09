Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVFIR7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVFIR7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVFIR7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:59:08 -0400
Received: from ee.oulu.fi ([130.231.61.23]:1728 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S262431AbVFIR7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 13:59:03 -0400
Date: Thu, 9 Jun 2005 20:58:59 +0300
From: Sami Tapio <flexy@ee.oulu.fi>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tcp_output.c BUG in 2.6.12-rc6-mm1 report
Message-ID: <20050609175859.GA22182@ee.oulu.fi>
References: <20050604195352.GA192@ee.oulu.fi> <20050608182638.GA13553@ee.oulu.fi> <20050608.124626.95058471.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608.124626.95058471.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 12:46:26PM -0700, David S. Miller wrote:
> 
> Just remove the BUG_ON() statement in tcp_tso_should_defer(), the
> assertion is just incorrect.

Well, don't know if it is incorrect or not, but my machine just 
hard locked again, no reaction to SysRQ SUB sequence, no reaction 
to anything else either, not answer to ping, nor ssh. Power off, 
power on was the only method to get the machine alive again. 

Only thing in the logs is the bug I've allready reported 2 times. 
Don't know if that bug is real or not, but the problem is real 
for sure.

BR,

Sami
