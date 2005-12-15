Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVLORg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVLORg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVLORg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:36:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35740 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750832AbVLORg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:36:28 -0500
Date: Thu, 15 Dec 2005 12:35:08 -0500
From: Dave Jones <davej@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Message-ID: <20051215173508.GC19354@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org> <20051214221304.GE23349@stusta.de> <9a8748490512141418w2a3811a9iffe83b5f285e2910@mail.gmail.com> <9a8748490512141428q29f39ca5x66d2c52e22aa9208@mail.gmail.com> <20051215004006.GA19354@redhat.com> <m3bqzijtev.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3bqzijtev.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 04:01:44PM +0100, Krzysztof Halasa wrote:
 > Dave Jones <davej@redhat.com> writes:
 > 
 > > Fedora has had this enabled most of the time for x86, x86-64, ia64,
 > > s390, s390x, ppc32 and ppc64 for a long time.  From time to time
 > > when a gcc bug has been tickled it's been disabled again until its
 > > been worked out, but for the most part, it's been a complete non-event
 > > wrt regressions.
 > 
 > BTW: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173764
 > 
 > gcc generates incorrect code with -Os (i386).

Ok, I'll concede and add that one to the list too ;)

		Dave
