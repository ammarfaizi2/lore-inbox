Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWEIQaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWEIQaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWEIQaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:30:09 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:39072 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750763AbWEIQaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:30:07 -0400
Date: Tue, 9 May 2006 17:29:59 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
Message-ID: <20060509162959.GL7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <4460AC06.4000303@mbligh.org> <20060509155153.GJ7834@cl.cam.ac.uk> <200605091807.57522.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605091807.57522.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 06:07:57PM +0200, Andi Kleen wrote:
> 
> > 
> > Anybody want to comment on the performance impact of making
> > local_irq_* non-inline functions?
> 
> I would guess for that much inline code it will be even a win to not
> inline because it will save icache.

Maybe, although some of the macros compile down to only 2-3 instructions.

    christian

