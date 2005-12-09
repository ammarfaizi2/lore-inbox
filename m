Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVLIP0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVLIP0c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVLIP0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:26:31 -0500
Received: from nevyn.them.org ([66.93.172.17]:24472 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932329AbVLIP02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:26:28 -0500
Date: Fri, 9 Dec 2005 10:26:25 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051209152625.GA13287@nevyn.them.org>
Mail-Followup-To: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Sachin Sant <sachinp@in.ibm.com>
References: <20051209140559.GA23868@suse.de> <20051209151348.GA12815@nevyn.them.org> <20051209151914.GA26653@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209151914.GA26653@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 04:19:14PM +0100, Olaf Hering wrote:
>  On Fri, Dec 09, Daniel Jacobowitz wrote:
> 
> > And... you're going to make it impossible to run ppp over the serial
> > console port.  For everyone, not just your big POWER4 boxes.  As far as
> > I know, if you turn off the printk log level, this should work just
> > fine today.
> 
> Can one send break (via ppp) in this setup?

Huh?

Maybe I'm misunderstanding your patch, but the issue is that you've
just made the serial console not-eight-bit-clean.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
