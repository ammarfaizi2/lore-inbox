Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUIISAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUIISAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUIIR6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:58:37 -0400
Received: from holomorphy.com ([207.189.100.168]:6578 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266585AbUIIR4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:56:44 -0400
Date: Thu, 9 Sep 2004 10:56:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040909175620.GE3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
	Scott Wood <scott@timesys.com>
References: <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com> <20040908143143.A32002@infradead.org> <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com> <1094652572.2800.14.camel@laptop.fenrus.com> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu> <20040909175748.A12336@infradead.org> <20040909172401.GA28376@elte.hu> <20040909175314.GD3106@holomorphy.com> <20040909175441.GA25686@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909175441.GA25686@devserv.devel.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 10:53:14AM -0700, William Lee Irwin III wrote:
>> By any chance can the generic code be made not to be reliant on
>> irq_desc[] and/or irq_desc[] being an array?

On Thu, Sep 09, 2004 at 07:54:41PM +0200, Arjan van de Ven wrote:
> I would say one step at a time.
> First extract out the code that most arch's share already
> only THEN start working on seeing if the few remaining ones can be moved in,
> and if other cleanups are appropriate

I suppose that assumption can be swept for afterward.


-- wli
