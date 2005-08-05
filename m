Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVHETvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVHETvG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVHETvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:51:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262823AbVHETvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:51:03 -0400
Date: Fri, 5 Aug 2005 12:50:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: Martin Loschwitz <madkiss@madkiss.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
Message-ID: <20050805195056.GB7991@shell0.pdx.osdl.net>
References: <20050805192628.GA24706@minerva.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805192628.GA24706@minerva.local.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Loschwitz (madkiss@madkiss.org) wrote:
> I just ran into the following problem: Having updated my box to 2.6.12.3, 
> I tried to start YaST2 and noticed a kernel panic (see below). Some quick
> debugging brought the result that the kernel crashes while some user (not
> even root ...) tries to access /proc/ioports. Is this a known problem and
> if so, is a fix available?

First I've heard of it.  I can't trigger here with simple cat
/proc/ioports.  Must be specific to your setup.  What was the last
working kernel, and what's that ioport output look like?

thanks,
-chris
