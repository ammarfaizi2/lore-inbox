Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWEIQbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWEIQbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWEIQbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:31:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:31647 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750766AbWEIQbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:31:43 -0400
From: Andi Kleen <ak@suse.de>
To: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
Date: Tue, 9 May 2006 18:31:37 +0200
User-Agent: KMail/1.9.1
Cc: virtualization@lists.osdl.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <200605091807.57522.ak@suse.de> <20060509162959.GL7834@cl.cam.ac.uk>
In-Reply-To: <20060509162959.GL7834@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091831.37757.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 18:29, Christian Limpach wrote:
> On Tue, May 09, 2006 at 06:07:57PM +0200, Andi Kleen wrote:
> > 
> > > 
> > > Anybody want to comment on the performance impact of making
> > > local_irq_* non-inline functions?
> > 
> > I would guess for that much inline code it will be even a win to not
> > inline because it will save icache.
> 
> Maybe, although some of the macros compile down to only 2-3 instructions.

Can you post before/after vmlinux size numbers for inline/out of line?

-Andi
