Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWHOOpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWHOOpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWHOOpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:45:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13443 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030323AbWHOOpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:45:30 -0400
Subject: Re: Shared page tables patch... some results
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: hugh@veritas.com, akpm@osdl.org, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <p73wt9a83it.fsf@verdi.suse.de>
References: <1155638047.3011.96.camel@laptopd505.fenrus.org>
	 <p73wt9a83it.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 15 Aug 2006 16:45:05 +0200
Message-Id: <1155653105.3011.167.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 16:41 +0200, Andi Kleen wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> > and the result is interesting:
> > Just booting into runlevel 5 and logging into gnome (without starting
> > any apps) gets a sharing of 1284 pte pages! This means that five
> > megabytes (!!) of memory is saved, and countless pagefaults are avoided.
> >
> 
> When I start SLES10 GNOME after boot with one firefox window and
> one gnome terminal I only have ~5.3MB in total page tables according
> to /proc/meminfo
> 
> You're saying you can share 5MB of those. Call me sceptical of your
> numbers.

PageTables:       9836 kB

(this is after sharing, so before it was more)

maybe your gnome is not as bloated as my gnome ;)



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

