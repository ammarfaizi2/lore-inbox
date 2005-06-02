Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVFBQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFBQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFBQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:30:16 -0400
Received: from relay.axxeo.de ([213.239.199.237]:56451 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261154AbVFBQaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:30:09 -0400
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [rfc] [patch] consolidate/clean up spinlock.h files
Date: Thu, 2 Jun 2005 18:30:03 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050602144004.GA31807@elte.hu> <200506021749.15206.ioe-lkml@axxeo.de> <20050602161633.GA12616@elte.hu>
In-Reply-To: <20050602161633.GA12616@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506021830.03652.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Ingo Molnar wrote:
> * Ingo Oeser <ioe-lkml@axxeo.de> wrote:
> > you wrote:
> > > --- linux/lib/spinlock_debug.c.orig
> > I would suggest propagating the __FILE__ and __LINE__ from the CALLERS
> the real call site info comes from dump_stack(). Maybe i should remove
> the __FILE__,__LINE__ info altogether. (albeit a bit redundancy wont
> hurt) I dont think we want to pass in __FILE__,__LINE__ all the way from
> the main APIs.

Then please remove the __FILE__ and __LINE__ altogether.

It looks confusing to me and enlarges code without providing
any useful additional information.


Regards

Ingo Oeser

