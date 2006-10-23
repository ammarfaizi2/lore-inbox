Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWJWLGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWJWLGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWJWLGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:06:03 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:56523 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751464AbWJWLGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:06:01 -0400
Date: Mon, 23 Oct 2006 13:05:57 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Gleb Natapov <glebn@voltaire.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e1000_request_irq returns ENOSYS on latest Linus' git
Message-ID: <20061023110557.GU4354@rhun.haifa.ibm.com>
References: <20061023094736.GC31776@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023094736.GC31776@minantech.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 11:47:36AM +0200, Gleb Natapov wrote:
> Hi,
> 
> See subj for problem description. Adding pci=routeirq to boot
> parameters solves the problem.
> 
> Attached are dmesg without pci=routeirq, lspci and my .config file.

Can you try Eric's two patches at
http://marc.theaimsgroup.com/?t=116157840300001&r=1&w=2? sounds like
they might fix it.

Cheers,
Muli
