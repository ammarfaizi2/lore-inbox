Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUIIRB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUIIRB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUIIQ7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:59:33 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:43528 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266310AbUIIQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:58:00 -0400
Date: Thu, 9 Sep 2004 17:57:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040909175748.A12336@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>,
	Arjan van de Ven <arjanv@redhat.com>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908125755.GC3106@holomorphy.com> <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com> <20040908143143.A32002@infradead.org> <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com> <1094652572.2800.14.camel@laptop.fenrus.com> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040908211415.GA20168@elte.hu>; from mingo@elte.hu on Wed, Sep 08, 2004 at 11:14:15PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 11:14:15PM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > latest patch attached - this should compile on every architecture.
> > It's basically what Christoph suggested first time around :-)
> > Compiles/boots on x86. Any other observations?
> 
> i've attached generic-hardirqs-2.6.9-rc1-mm4.patch which is a merge
> against -mm4. x86 and x64 compiles & boots fine. Since there are zero
> changes to non-x86 architectures it should build fine on all platforms.

Looks good to me.  I no one else beats me I'll look into converting
ppc32/64 this weekend.
