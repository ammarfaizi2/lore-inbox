Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbUKSMAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbUKSMAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbUKSL6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 06:58:30 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:54463 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261363AbUKSL5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 06:57:50 -0500
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
From: David Woodhouse <dwmw2@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041119115539.GC21483@wotan.suse.de>
References: <20041119005117.GM4943@stusta.de>
	 <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com>
	 <20041119103418.GB30441@wotan.suse.de>
	 <1100863700.21273.374.camel@baythorne.infradead.org>
	 <20041119115539.GC21483@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1100865050.21273.376.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 19 Nov 2004 11:50:50 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 12:55 +0100, Andi Kleen wrote:
> On Fri, Nov 19, 2004 at 11:28:20AM +0000, David Woodhouse wrote:
> > Can you show some examples? We don't have this for any other
> > architecture.
> 
> Just grep for any use of X86 in Kconfig.

OK, I'll pick the first I find...

config ATP
        tristate "AT-LAN-TEC/RealTek pocket adapter support"
        depends on NET_POCKET && ISA && X86

Why is that OK on x86_64 but not Alpha? Why isn't the use of X86 a bug
in that case?

-- 
dwmw2


