Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWABJSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWABJSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 04:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWABJSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 04:18:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30985 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932339AbWABJSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 04:18:15 -0500
Date: Mon, 2 Jan 2006 09:18:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SysReq & serial console
Message-ID: <20060102091808.GA11673@flint.arm.linux.org.uk>
Mail-Followup-To: Kalin KOZHUHAROV <kalin@thinrope.net>,
	linux-kernel@vger.kernel.org
References: <43B8696B.2070303@gmx.de> <dpakp2$tip$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dpakp2$tip$3@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 04:29:38PM +0900, Kalin KOZHUHAROV wrote:
> Another wild guess: the syslog is still running and writes the output to
> the log.

I don't think syslog can influence whether you see sysrq output via the
console.  Nevertheless, try sysrq-8 before other sysrq functions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
