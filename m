Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVBCIjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVBCIjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVBCIjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:39:01 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:53474 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262831AbVBCIh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:37:27 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: i386 HPET code
Date: Thu, 3 Feb 2005 08:37:09 +0000
User-Agent: KMail/1.7.2
Cc: john stultz <johnstul@us.ibm.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, keith maanthey <kmannth@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
References: <1107396306.2040.237.camel@cog.beaverton.ibm.com>
In-Reply-To: <1107396306.2040.237.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502030837.09331.andrew@walrond.org>
X-Spam-Score: -2.8 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 February 2005 02:05, john stultz wrote:
> Hey Venkatesh,
>  I've been looking into a bug where i386 2.6 kernels do not boot on IBM
> e325s if HPET_TIMER is enabled (hpet=disable works around the issue).
> When running x86-64 kernels, the issue isn't seen. It appears that after

FWIW The problem is not limited to the IBM e325. I cannot boot a HPET_TIMER 
enabled x86 kernel on any of the various Tyan and MSI opteron boards I have 
here without hpet=disable. x86_64 kernels work fine.

Andrew Walrond
