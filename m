Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVHCM55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVHCM55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVHCM55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:57:57 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:8851 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262267AbVHCM5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:57:53 -0400
Date: Wed, 3 Aug 2005 14:57:52 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Jules Colding <colding@omesc.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Segfaults in mkdir under high load. Software or hardware?
Message-ID: <20050803125752.GA2912@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Jules Colding <colding@omesc.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1123071243.6758.18.camel@omc-2.omesc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123071243.6758.18.camel@omc-2.omesc.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 02:14:03PM +0200, Jules Colding wrote:
> I am experiencing segfaults in mkdir, and mkdir alone, under high load.

I've seen errors like these happen, and they were kernel bugs.

> [    0.000000] Bootdata ok (command line is root=/dev/sda4 vga=0x31B video=vesafb:mtrr,ywrap)
> [    0.000000] Linux version 2.6.12-gentoo-r6 (root@omc-2) (gcc version 3.4.3 20041125 (Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #6 SMP Mon Jul 25 13:50:58 CEST 2005

If you reproduce with an unpatched kernel and an unpatched compiler, you are
much more likely to get attention. Your problem might also just go away.

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
