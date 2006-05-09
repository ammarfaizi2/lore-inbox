Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWEIWjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWEIWjA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWEIWjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:39:00 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:10886 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751327AbWEIWi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:38:59 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 03/35] Add Xen interface header files
Date: Wed, 10 May 2006 00:36:00 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085147.903310000@sous-sol.org> <20060509151516.GA16332@infradead.org>
In-Reply-To: <20060509151516.GA16332@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605100036.02776.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tuesday, 9. May 2006 17:15, Christoph Hellwig wrote:
> > Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> > ---
> >  include/xen/interface/arch-x86_32.h   |  197 +++++++++++++++
> 
> that kind of stuff needs to go to asm/
> 
> >  include/xen/interface/event_channel.h |  205 +++++++++++++++
> 
> instead of interface please use something shorter, we'll see this
> all over the includes statements.  intf for example.

I like them and think they are quite clear.

Documentation/CodingStyle Chapter 4: Naming
seem to apply here.

And since you type the include only ONCE per file,
this looks like a good trade, doesn't it?


Regards

Ingo Oeser
