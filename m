Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbUFCMiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUFCMiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUFCMiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:38:11 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:55998 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263389AbUFCMiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:38:09 -0400
Date: Thu, 3 Jun 2004 13:37:14 +0100
From: Dave Jones <davej@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CPUFREQ] Make powernow-k7 work with CONFIG_ACPI_PROCESSOR == m
Message-ID: <20040603123714.GF7794@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040603121704.GB8164@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603121704.GB8164@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 10:17:04PM +1000, Herbert Xu wrote:
 > Hi:
 > 
 > The last round of updates to powernow-k7.c broke it when
 > CONFIG_ACPI_PROCESSOR is built as a module.  This patch
 > fixes that.
 
How strange, I could swear I already merged this patch into
the last round that went to Linus.  I'll make sure it gets
into the next one. There's been some corruption with the
cpufreq -bk tree the last few days which has only just got
fixed up, so I'm a little behind on cpufreq patches.

		Dave

