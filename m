Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVFXHCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVFXHCo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 03:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVFXHCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 03:02:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29626 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262553AbVFXHBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 03:01:13 -0400
Date: Fri, 24 Jun 2005 09:00:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, nickpiggin@yahoo.com.au
Subject: Re: recent sched.c broke cpu hotplug
Message-ID: <20050624070017.GA5941@elte.hu>
References: <20050623143003.A25031@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623143003.A25031@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ashok Raj <ashok.raj@intel.com> wrote:

> Hi Andrew
> 
> trivial fix, this is required for getting cpu hotplug to work. These 
> functions are called during cpu down, but marked __init instead of 
> __devinit.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
