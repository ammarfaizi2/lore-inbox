Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263421AbTC2OOD>; Sat, 29 Mar 2003 09:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263423AbTC2OOD>; Sat, 29 Mar 2003 09:14:03 -0500
Received: from home.wiggy.net ([213.84.101.140]:49858 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S263421AbTC2OOC>;
	Sat, 29 Mar 2003 09:14:02 -0500
Date: Sat, 29 Mar 2003 15:25:20 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: NIC renaming does not rename /proc/sys/net/ipv4 Was: Re: NICs trading places ?
Message-ID: <20030329142519.GG2078@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030328221037.GB25846@suse.de.suse.lists.linux.kernel> <p73isu2zsmi.fsf@oldwotan.suse.de> <20030329121755.GA17169@outpost.ds9a.nl> <1048940960.2176.86.camel@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048940960.2176.86.camel@averell>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andi Kleen wrote:
> Just rename at early boot before IP is set up.  That is what i usually
> do - set up /etc/mactab and run it very early at boot.

How does that solve the problem of /proc/sys/net/*/conf/* not being
renamed?

Another problem is that nameif only supports ethernet devices currently,
making it an incomplete solution.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
