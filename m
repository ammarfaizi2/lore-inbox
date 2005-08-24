Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVHXEZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVHXEZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 00:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbVHXEZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 00:25:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:54423 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751446AbVHXEZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 00:25:30 -0400
From: Andi Kleen <ak@suse.de>
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] Add MCE resume under ia32
Date: Wed, 24 Aug 2005 06:26:13 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com.suse.lists.linux.kernel> <200508240559.16931.ak@suse.de> <1124856986.5310.2.camel@linux-hp.sh.intel.com>
In-Reply-To: <1124856986.5310.2.camel@linux-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508240626.13475.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 August 2005 06:16, Shaohua Li wrote:

> The boot code already initialized MCE for APs, it isn't required to
> initialize again. The MCE entries are cpuhotplug friendly, so for
> suspend/resume.

Ok so you're saying the only change needed is to remove
the on_each_cpu() in the resume method? Fine I can do that.

-Andi
