Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317550AbSGJQxH>; Wed, 10 Jul 2002 12:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317559AbSGJQxG>; Wed, 10 Jul 2002 12:53:06 -0400
Received: from holomorphy.com ([66.224.33.161]:10128 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317546AbSGJQxD>;
	Wed, 10 Jul 2002 12:53:03 -0400
Date: Wed, 10 Jul 2002 09:54:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Chow <davidchow@shaolinmicro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU load
Message-ID: <20020710165443.GA15916@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Chow <davidchow@shaolinmicro.com>,
	linux-kernel@vger.kernel.org
References: <1026312615.6584.18.camel@star15.staff.shaolinmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1026312615.6584.18.camel@star15.staff.shaolinmicro.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 10:50:15PM +0800, David Chow wrote:
> Is there any calls in the kernel space I can determine the current
> system load or CPU load?

Examine the avenrun array declared in kernel/timer.c in a manner similar
to how loadavg_read_proc() in fs/proc/proc_misc.c does.


Cheers,
Bill
