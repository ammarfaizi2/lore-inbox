Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTIWRqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTIWRqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:46:15 -0400
Received: from havoc.gtf.org ([63.247.75.124]:49341 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262127AbTIWRqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:46:13 -0400
Date: Tue, 23 Sep 2003 13:46:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICH5-SATA drivers freeze system when drives are spun down
Message-ID: <20030923174613.GA27629@gtf.org>
References: <87k77zqv1s.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k77zqv1s.fsf@stark.dyndns.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 01:22:23PM -0400, Greg Stark wrote:
> I've always used noflushd to spin down the drives I don't use much. Some of my
> older drives are really noise, and there's enough heat in there as it is. I
> just switched to a new system and I find on my new motherboard with a ICH5
> SATA controller the system doesn't behave properly when the drives are spun
> down.
> 
> The entire system freezes periodically for anywhere from half a second to 10s.
> This happens about once a minute or so, sometimes more. During this time the
> entire system is frozen, but when it recovers it processes all the lost i/o.


Are you using my libata driver, or the stock drivers/ide driver?

The stock drivers/ide ICH5 SATA driver in known to lock up in many
cases, not just the one you described.

	Jeff



