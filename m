Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932665AbWBYElN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbWBYElN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWBYElN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:41:13 -0500
Received: from cantor.suse.de ([195.135.220.2]:5335 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932665AbWBYElM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:41:12 -0500
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: don't use early_printk() during memory init
Date: Sat, 25 Feb 2006 05:26:05 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200602242049_MC3-1-B938-400B@compuserve.com>
In-Reply-To: <200602242049_MC3-1-B938-400B@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602250526.06389.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 02:45, Chuck Ebbert wrote:
> printk is working by the time this memory init message prints.
> As it stands, output jumps to the top of the screen and prints
> this message, then back to normal boot messages, overwriting
> a line at the top.

Using of early_printk here was intentional because it needs
much less infrastructure than printk and is pretty good proof
that the kernel at least started.

So please don't apply the patch.

-Andi
