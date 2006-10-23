Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751935AbWJWMbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbWJWMbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 08:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWJWMbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 08:31:33 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:10535 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1751935AbWJWMbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 08:31:33 -0400
Date: Mon, 23 Oct 2006 14:31:30 +0200
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e1000_request_irq returns ENOSYS on latest Linus' git
Message-ID: <20061023123130.GD31776@minantech.com>
References: <20061023094736.GC31776@minantech.com> <20061023110557.GU4354@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023110557.GU4354@rhun.haifa.ibm.com>
From: glebn@voltaire.com (Gleb Natapov)
X-OriginalArrivalTime: 23 Oct 2006 12:31:30.0793 (UTC) FILETIME=[2AFA7D90:01C6F69F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 01:05:57PM +0200, Muli Ben-Yehuda wrote:
> On Mon, Oct 23, 2006 at 11:47:36AM +0200, Gleb Natapov wrote:
> > Hi,
> > 
> > See subj for problem description. Adding pci=routeirq to boot
> > parameters solves the problem.
> > 
> > Attached are dmesg without pci=routeirq, lspci and my .config file.
> 
> Can you try Eric's two patches at
> http://marc.theaimsgroup.com/?t=116157840300001&r=1&w=2? sounds like
> they might fix it.
> 
Those patches fixes the problem. Thanks Muli.

--
			Gleb.
