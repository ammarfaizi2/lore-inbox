Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWJVVdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWJVVdi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 17:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWJVVdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 17:33:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45457 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750771AbWJVVdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 17:33:37 -0400
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Date: Sun, 22 Oct 2006 23:33:31 +0200
User-Agent: KMail/1.9.5
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <200610212100.k9LL0GtC018787@hera.kernel.org> <86802c440610220902q648a7fc8p38fd9a3391f5bc5d@mail.gmail.com> <86802c440610220919h5e2fb98axb5ba4dd4d073171@mail.gmail.com>
In-Reply-To: <86802c440610220919h5e2fb98axb5ba4dd4d073171@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610222333.31834.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 18:19, yhlu wrote:
> andi,
> 
> the per_cpu only can be used with online cpus?

It can be used for all possible cpus. This means some subsystems
initialize their state only for online CPUs, but the compile
time initialization is available for all possible ones.

-Andi
