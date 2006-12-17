Return-Path: <linux-kernel-owner+w=401wt.eu-S1752517AbWLQMTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbWLQMTl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 07:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbWLQMTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 07:19:41 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:40538 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbWLQMTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 07:19:40 -0500
Date: Sun, 17 Dec 2006 13:19:38 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: Andrew Morton <akpm@osdl.org>
Cc: andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Florian Weimer <fw@deneb.enyo.de>
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061217121938.GA21058@torres.l21.ma.zugschlus.de>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061217040620.91dac272.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2006 at 04:06:20AM -0800, Andrew Morton wrote:
> I'd be really surprised if this was all due to a race though.  Is everyone
> who has observed this problem running SMP and/or premptible kernels?

Linux torres 2.6.19.1-zgsrv #1 SMP PREEMPT Wed Dec 13 01:31:27 UTC 2006 i686 GNU/Linux

So, it's a "yes" to both counts, and I'll build a kernel without SMP
and without preemption asap.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
