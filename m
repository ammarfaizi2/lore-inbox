Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbULIHT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbULIHT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 02:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbULIHT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 02:19:26 -0500
Received: from havoc.gtf.org ([69.28.190.101]:23683 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261467AbULIHTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 02:19:22 -0500
Date: Thu, 9 Dec 2004 02:19:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: felix-linuxkernel@fefe.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipv6 getting more and more broken
Message-ID: <20041209071921.GA9080@havoc.gtf.org>
References: <20041209024649.GA26553@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209024649.GA26553@codeblau.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 03:46:49AM +0100, felix-linuxkernel@fefe.de wrote:
> In 2.6.9, the machines don't even get a link-local address when bringing
> an interface up!  This is so utterly and completely broken, how can it
> be that nobody has noticed this yet?  I have compiled in ipv6
> statically, not as a module, but that should not matter, right?

I've seen a couple link-local-addr-related bug reports.  Not sure if
those have been discussed yet.

In general, there have been a bunch of IPv6 fixes recently, can you
please test 2.6.10-rc3 (and/or 2.6.10-rc3-bk3)?

	Jeff


