Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbTAWLPb>; Thu, 23 Jan 2003 06:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTAWLPb>; Thu, 23 Jan 2003 06:15:31 -0500
Received: from dp.samba.org ([66.70.73.150]:56449 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265098AbTAWLPb>;
	Thu, 23 Jan 2003 06:15:31 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15919.52605.186820.873536@argo.ozlabs.ibm.com>
Date: Thu, 23 Jan 2003 22:09:49 +1100
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>, <benh@kernel.crashing.org>
Subject: Re: [PATCH][2.5][10/18] smp_call_function_on_cpu - ppc
In-Reply-To: <Pine.LNX.4.44.0301220028240.29944-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0301220028240.29944-100000@montezuma.mastecende.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo writes:

> +	if (num_cpus == 0 || )
> +		return -EINVAL;

Doesn't look to me like this will even compile. :(

Paul.
