Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268383AbUI2NKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268383AbUI2NKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUI2NKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:10:08 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:33540 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268383AbUI2NJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:09:12 -0400
Date: Wed, 29 Sep 2004 14:09:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Carpani <andrea.carpani@criticalpath.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec aic79xx driver status
Message-ID: <20040929140909.A12373@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Carpani <andrea.carpani@criticalpath.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <415AB021.70605@criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <415AB021.70605@criticalpath.net>; from andrea.carpani@criticalpath.net on Wed, Sep 29, 2004 at 02:52:49PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 02:52:49PM +0200, Andrea Carpani wrote:
> As of linux 2.6.8.1 the aic79xx driver included is version 1.3.11 which 
> dates back to July 11, 2003.
> 
> On my Tyan B2881 the used scsi controller has a lot of problems: as soon 
> as I try to transfer some data I get a frozen scsi subsystem and a dump 
> in the syslog messages.
> 
> I hope to be able to solve these problems by using the new driver found 
> at http://people.freebsd.org/~gibbs/linux/SRC/
> 
> My question is: why isn't the new version included in the main tree?

Because it's broken in various ways.  We're working with Adaptec to get
the fixes merged but not the bogus parts.  But as Justin didn't cooperate
the new engineer in his position has a hard time to untangle the mess, so
it'll take a while.

