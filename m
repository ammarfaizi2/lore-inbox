Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274814AbTHKVu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 17:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274837AbTHKVu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 17:50:29 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:1165
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S274814AbTHKVu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 17:50:28 -0400
From: Con Kolivas <kernel@kolivas.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test3-mm1
Date: Tue, 12 Aug 2003 07:55:54 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <20030809203943.3b925a0e.akpm@osdl.org> <94490000.1060612530@[10.10.2.4]> <20030811180552.GG32488@holomorphy.com>
In-Reply-To: <20030811180552.GG32488@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120755.54518.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 04:05, William Lee Irwin III wrote:
> On Mon, Aug 11, 2003 at 07:35:31AM -0700, Martin J. Bligh wrote:
> > Degredation on kernbench is still there:
> > Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
> >                               Elapsed      System        User         CPU
> >               2.6.0-test3       45.97      115.83      571.93     1494.50
> >           2.6.0-test3-mm1       46.43      122.78      571.87     1496.00
> > Quite a bit of extra sys time. I thought the suspected part of the sched
> > changes got backed out, but maybe I'm just not following it ...
>
> Is this with or without the unit conversion fix for the load balancer?
>
> It will be load balancing extra-aggressively without the fix.

Yes, test3-mm1 includes load balancing fix you suggested in an akpm modified 
form.

Con

