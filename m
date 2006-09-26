Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWIZQLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWIZQLy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWIZQLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:11:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19604 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932337AbWIZQLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:11:41 -0400
Subject: Re: [SYSFS] Add a declaration for fs_subsys
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060926160043.GA2402@infradead.org>
References: <1159274711.11901.460.camel@quoit.chygwyn.com>
	 <20060926160043.GA2402@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 26 Sep 2006 17:18:08 +0100
Message-Id: <1159287488.11901.514.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-09-26 at 17:00 +0100, Christoph Hellwig wrote:
> On Tue, Sep 26, 2006 at 01:45:11PM +0100, Steven Whitehouse wrote:
> > 
> > The fs_subsys of sysfs does not have a declaration in any header
> > file, despite it being an exported symbol. This patch adds one so
> > that modules don't have to add their own. This is something used
> > by GFS2 (and already in the GFS2 tree) but I think can safely be
> > considered generic infrastructure.
> 
> The declaration seem to be already present in Linus' current tree.
> 

Oops. Sorry, I'd totally missed that. I've backed out the second
declaration from the GFS2 tree,

Steve.


