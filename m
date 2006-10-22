Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWJVQuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWJVQuU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWJVQuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:50:20 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:22777 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751124AbWJVQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:50:18 -0400
Date: Sun, 22 Oct 2006 18:50:15 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86-64: using cpu_online_map instead of APIC_ALL_CPUS
Message-ID: <20061022165015.GH4354@rhun.haifa.ibm.com>
References: <86802c440610220942m4fc77edbi7b6d62a2b2b378c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610220942m4fc77edbi7b6d62a2b2b378c5@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 09:42:38AM -0700, Yinghai Lu wrote:
> Using cpu_online_map instead of APIC_ALL_CPUS for flat apic mode, So
> __assign_irq_vector can refer correct per_cpu data.
> 
> Cc: Muli Ben-Yehuda <muli@il.ibm.com>
> Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

Cheers,
Muli
