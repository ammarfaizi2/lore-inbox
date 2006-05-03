Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWECGxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWECGxa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 02:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWECGxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 02:53:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1996 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965113AbWECGx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 02:53:29 -0400
Date: Wed, 3 May 2006 08:58:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH -rt] Make RCU API inaccessible to non-GPL Linux kernel modules
Message-ID: <20060503065803.GA23921@elte.hu>
References: <20060502182442.GA2134@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502182442.GA2134@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> This patch removes synchronize_kernel() (deprecated 2-APR-2005 in 
> http://lkml.org/lkml/2005/4/3/11) and makes the RCU API inaccessible 
> to non-GPL Linux kernel modules (as was announced more than one year 
> ago in http://lkml.org/lkml/2005/4/3/8).  Tested on x86 and ppc64.
> 
> Same as the one sent yesterday, but for -rt rather than mainline.
> 
> Ingo, please apply.

thanks, applied.

	Ingo
