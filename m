Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932844AbWJGUrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbWJGUrh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 16:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbWJGUrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 16:47:37 -0400
Received: from outmx010.isp.belgacom.be ([195.238.5.233]:38820 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932844AbWJGUrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 16:47:36 -0400
Date: Sat, 7 Oct 2006 22:47:19 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>
Cc: Amol Lad <amol@verismonetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] ioremap balanced with iounmap for drivers/char/watchdog/s3c2410_wdt.c
Message-ID: <20061007204719.GA2399@infomag.infomag.iguana.be>
References: <1160110627.19143.88.camel@amol.verismonetworks.com> <20061006134104.9bd4dcf1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006134104.9bd4dcf1.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> barf.  That function has to set the record for the
> number-of-return-statements-per-line.  There are good reasons why we prefer
> to have a single return point at which to handle all the error unwinding,
> and the above patch illustrates one of them.
> 
> Sigh.  Oh well, patch looks correct - I'll start spamming Wim with it,
> thanks.
> 
> (Not that Wim - this Wim).

Added it to the linux-2.6-watchdog-mm tree.

Greetings,
Wim.

