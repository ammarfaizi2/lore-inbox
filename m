Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVEMLXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVEMLXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 07:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVEMLXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 07:23:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50108 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262240AbVEMLWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 07:22:31 -0400
Date: Thu, 12 May 2005 16:29:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Nyberg <alexn@telia.com>
Cc: Jan Beulich <JBeulich@novell.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050512142920.GA7079@openzaurus.ucw.cz>
References: <s2832159.057@emea1-mh.id2.novell.com> <1115892008.918.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115892008.918.7.camel@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > (Note: Patch also attached because the inline version is certain to get
> > line wrapped.)
> > 
> > Get the x86-64 watchdog tick calculation into a state where it can also
> > be used with nmi_hz other than 1Hz. Also do not turn on the watchdog by
> > default (as is already done on i386).
> > 
> 
> Why shouldn't the watchdog be turned on by default? It's an extremely
> useful debugging aid and it's not like it fires NMIs often (the nmi_hz
> is far from reality).

Because it kills machine when interrupt latency gets too high?
Like reading battery status using i2c...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

