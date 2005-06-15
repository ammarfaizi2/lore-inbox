Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVFOWAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVFOWAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVFOV65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:58:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:53218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261614AbVFOV6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:58:38 -0400
Date: Wed, 15 Jun 2005 14:58:23 -0700
From: Greg KH <greg@kroah.com>
To: Reiner Sailer <sailer@watson.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LSM <linux-security-module@wirex.com>,
       Tom Lendacky <toml@us.ibm.com>, Chris Wright <chrisw@osdl.org>,
       Emily Rattlif <emilyr@us.ibm.com>, Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 4 of 5 IMA: module measurement patch
Message-ID: <20050615215823.GA539@kroah.com>
References: <1118847443.2269.22.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118847443.2269.22.camel@secureip.watson.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 10:57:23AM -0400, Reiner Sailer wrote:
> +extern int ima_terminating;
> +extern void measure_kernel_module(void *start, unsigned long len, const char __user *uargs);

These belong in a .h file somewhere.

The later one is not a good global symbol name either.

So, from what I can see, you dropped your sysfs interfaces entirely?

thanks,

greg k-h
