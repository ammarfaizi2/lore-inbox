Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVAKKyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVAKKyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVAKKxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:53:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35977 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262717AbVAKKxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:53:17 -0500
Date: Tue, 11 Jan 2005 05:49:49 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] 2.4.19-rc1 stack reduction patches
Message-ID: <20050111074949.GE18796@logos.cnet>
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com> <1105429144.3917.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105429144.3917.0.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 08:39:03AM +0100, Arjan van de Ven wrote:
> On Mon, 2005-01-10 at 09:35 -0800, Badari Pulavarty wrote:
> > Hi Marcelo,
> > 
> > I re-worked all the applicable stack reduction patches for 2.4.19-rc1.
> 
> is it really worth doing this sort of thing for 2.4 still? It's a matter
> of risk versus gain... not sure this sort of thing is still worth it in
> the deep-maintenance 2.4 tree

Well it seems the s390 fellows are seeing stack overflows, which are serious
enough. Have you noticed that?

Moreover this are simple changes, not complex ones.
