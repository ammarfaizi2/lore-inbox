Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTI2WVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 18:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTI2WVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 18:21:53 -0400
Received: from smtp5.hy.skanova.net ([195.67.199.134]:36334 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262987AbTI2WVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 18:21:52 -0400
To: Ricardo Galli <gallir@uib.es>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6-mm1: too many defunct event threads
References: <200309292115.57918.gallir@uib.es>
	<20030929122709.B6895@osdlab.pdx.osdl.net>
	<200309292147.12595.gallir@uib.es>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Sep 2003 00:21:44 +0200
In-Reply-To: <200309292147.12595.gallir@uib.es>
Message-ID: <m2d6dj1bif.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli <gallir@uib.es> writes:

> BTW, we cannot find the reason for the synaptics timeouts:
> 
> Synaptics driver lost sync at 4th byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver resynced.
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver resynced.
> 
> which are the only glitches I find to it.

Did you try to modify the driver to use low packet rate reporting, ie
40 packets/s instead of 80?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
