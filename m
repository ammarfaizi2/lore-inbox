Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266086AbUFJBji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266086AbUFJBji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 21:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbUFJBji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 21:39:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20705 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266086AbUFJBjf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 21:39:35 -0400
Date: Thu, 10 Jun 2004 02:39:34 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: minyard@mvista.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/char/ipmi/ipmi_devintf.c: user/kernel pointer typo
Message-ID: <20040610013934.GA12308@parcelfarce.linux.theplanet.co.uk>
References: <1086822299.32056.134.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086822299.32056.134.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 04:04:59PM -0700, Robert T. Johnson wrote:
> Judging from context, I think there's a misplaced "&" in this code that
> can cause stack overflows and other nasty problems.  Perhaps it's left 
> over from when msgdata was an array instead of a pointer?  Let me know 
> if you have any questions or I made a mistake.

ACK.
