Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270438AbTGRX0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271795AbTGRX0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:26:24 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:33798
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270438AbTGRX0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:26:23 -0400
Date: Fri, 18 Jul 2003 16:41:29 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] O7int for interactivity
Message-ID: <20030718234129.GH2289@matchmail.com>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
	Davide Libenzi <davidel@xmailserver.org>
References: <200307190210.49687.kernel@kolivas.org> <20030718230717.GG2289@matchmail.com> <200307190930.37447.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307190930.37447.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 09:30:37AM +1000, Con Kolivas wrote:
> On Sat, 19 Jul 2003 09:07, Mike Fedyk wrote:
> > On Sat, Jul 19, 2003 at 02:10:49AM +1000, Con Kolivas wrote:
> > > Here is an update to my Oint patches for 2.5/6 interactivity. Note I will
> > Is this on top of 06 or 06.1?
> 
> On top of O6.1.
> 

Thanks,

Compiling 07int now.

Oh, btw, I had a few starvation problems while testing 06int and mozilla.

I was able to get mozilla to livelock, and it's pri would stay at 15, and
badblocks run niced at 5 would get completely starved, no activity, or only
a few KB/s compared to the normal 40MB/s.  I think that even happened when
it was at nice 0, but I'm not sure.

Anyway, I'll be trying the same workload on 07int.

Mike
