Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754937AbWKQGrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937AbWKQGrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 01:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754947AbWKQGrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 01:47:36 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:56544 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1754937AbWKQGrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 01:47:35 -0500
Date: Fri, 17 Nov 2006 08:47:32 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Yitzchak Eidus <ieidus@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changing internal kernel system mechanism in runtime by a module patch
Message-ID: <20061117064732.GC3735@rhun.zurich.ibm.com>
References: <e7aeb7c60611161119h3e198e96va07d36d5b2dd6390@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7aeb7c60611161119h3e198e96va07d36d5b2dd6390@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 09:19:50PM +0200, Yitzchak Eidus wrote:

> is it possible to replace linux kernel internal functions such as
> schdule () to lets say my_schdule () in a run time with a module
> patch???  (so that every call in the kernel to schdule() will go to
> my_schdule()... ) ???

Not in Linux.

> i am talking about a clean/standard way to do such thing
> (without overwrite the mem address of the function and replace it in a
> dirty way...)

k42 supports "dynamic hot-swap" and there's been some work done to
bring it into Linux, see e.g.,
http://ozlabs.org/pipermail/k42-discussion/2006-October/001615.html.

Cheers,
Muli


