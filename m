Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbUCLUSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbUCLUQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:16:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31114 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262424AbUCLUKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:10:49 -0500
Date: Fri, 12 Mar 2004 21:08:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard A Nelson <cowboy@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: swsusp (Re: 2.6.4-mm1 boot)
Message-ID: <20040312200821.GC1236@openzaurus.ucw.cz>
References: <20040310233140.3ce99610.akpm@osdl.org> <Pine.LNX.4.58.0403111244510.1855@onpx40.onqynaqf.bet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403111244510.1855@onpx40.onqynaqf.bet>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> IBM Thinkpad T30, current bios
> 
> On a clean boot (not resume - I've not gotten that working):
> resuming from /dev/hda8
> Resuming from device hda8
> bad: scheduling while atomic!


Boot with "noresume", then mkswap /dev/hda8.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

