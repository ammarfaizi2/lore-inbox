Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVJZVUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVJZVUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVJZVUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:20:22 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:36058 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S964936AbVJZVUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:20:21 -0400
From: Steve Snyder <R00020C@freescale.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: "Badness in local_bh_enable" - a reasonable fix?
Date: Wed, 26 Oct 2005 17:20:11 -0400
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200510261534.38291.R00020C@freescale.com> <200510261601.19369.R00020C@freescale.com> <1130358242.4483.127.camel@mindpipe>
In-Reply-To: <1130358242.4483.127.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261720.11478.R00020C@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 16:24, Lee Revell wrote:
> On Wed, 2005-10-26 at 16:01 -0400, Steve Snyder wrote:
> > What, you mean the driver?  No, it is built from source against the
> > installed & running Fedora Core 3 kernel version 2.6.12-1.1380_FC3. 
> 
> No, your kernel is tainted because you loaded some otehr proprietary
> module.  Maybe nvidia?

Yes, I did have the nvidia binary kernel module loaded.  After removing
it (not uninstalling; I just specified use of the X.org vesa driver
instead and rebooted) I get the same behavior - including the Tainted
notation.

Thanks.
