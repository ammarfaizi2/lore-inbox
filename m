Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269099AbUJTSoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269099AbUJTSoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUJTSoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:44:03 -0400
Received: from bender.bawue.de ([193.7.176.20]:42174 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S268944AbUJTSWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:22:04 -0400
Date: Wed, 20 Oct 2004 20:17:19 +0200
From: Joerg Sommrey <jo175@sommrey.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9: io conflict between w83627hf_wdt and parport_pc
Message-ID: <20041020181719.GA6395@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo175@sommrey.de>,
	Lee Revell <rlrevell@joe-job.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041020165408.GA5872@sommrey.de> <1098292880.1429.129.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098292880.1429.129.camel@krustophenia.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 01:21:20PM -0400, Lee Revell wrote:
> On Wed, 2004-10-20 at 12:54, Joerg Sommrey wrote:
> > /proc/ioports reports:
> > |002e-0030 : winbond_check
> 
> Ugh.  Looks like this bug made it into 2.6.9:
> 
> http://lkml.org/lkml/2004/10/18/58
Thanks for the pointer.  Andrea's parport_pc-superio-chip-fixes.patch
fixed this bug for me.

-jo

-- 
-rw-r--r--  1 jo users 63 2004-10-20 20:11 /home/jo/.signature
