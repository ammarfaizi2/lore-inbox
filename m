Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUCYOY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUCYOY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:24:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39386 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263160AbUCYOYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:24:51 -0500
Date: Thu, 18 Mar 2004 08:25:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: jpearson@oasissystems.com.au, linux-kernel@vger.kernel.org
Subject: Re: strange ext3 corruption problem on 2.6.x
Message-ID: <20040318072521.GB597@openzaurus.ucw.cz>
References: <20040314222929.GA23106@mark> <20040315034125.GA5295@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315034125.GA5295@schmorp.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 'r/o' by the RAID layer, presumably unbeknownst to VFS; are you
> > *sure* that your array is still up and 'good' when you get this
> > message?
> 
> As I said, there are no other messages, so if there is a problem (cabling,
> disk-i/o etc.), then the kernel doesn't know it either (usually the kernel
> it quite loud in this condition).

Hmm, is there way to force raid5 to check parity?
Mostly "degraded" mode with all disks online. Could be
usefull for cabling problems and debugging raid...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

