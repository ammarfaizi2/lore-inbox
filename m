Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVFISYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFISYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 14:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFISYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 14:24:04 -0400
Received: from ee.oulu.fi ([130.231.61.23]:43465 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261251AbVFISYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 14:24:00 -0400
Date: Thu, 9 Jun 2005 21:23:53 +0300
From: Sami Tapio <flexy@ee.oulu.fi>
To: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       dwm@maxeymade.com
Subject: Re: tcp_output.c BUG in 2.6.12-rc6-mm1 report
Message-ID: <20050609182353.GA25840@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 01:09:32PM -0500, Doug Maxey wrote:
> 
> On Thu, 09 Jun 2005 20:58:59 +0300, Sami Tapio wrote:
> >On Wed, Jun 08, 2005 at 12:46:26PM -0700, David S. Miller wrote:
> >> 
> >> Just remove the BUG_ON() statement in tcp_tso_should_defer(), the
> >> assertion is just incorrect.
> >
> >Well, don't know if it is incorrect or not, but my machine just 
> >hard locked again, no reaction to SysRQ SUB sequence, no reaction 
> >to anything else either, not answer to ping, nor ssh. Power off, 
> >power on was the only method to get the machine alive again. 
> >
> >Only thing in the logs is the bug I've allready reported 2 times. 
> >Don't know if that bug is real or not, but the problem is real 
> >for sure.
> >
> 
> I see these on a ICH5 based system.  Are you running wine by chance?
> 

I have wine installed, but no, I've not been running it in months.


Sami

