Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVBJUBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVBJUBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVBJUBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:01:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:30884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261477AbVBJUBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:01:16 -0500
Date: Thu, 10 Feb 2005 12:01:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Jack O'Quin" <joq@io.com>
Subject: Re: 2.6.11-rc3-mm2
Message-Id: <20050210120106.5b726272.akpm@osdl.org>
In-Reply-To: <20050210133524.GA4544@infradead.org>
References: <20050210023508.3583cf87.akpm@osdl.org>
	<20050210133524.GA4544@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Feb 10, 2005 at 02:35:08AM -0800, Andrew Morton wrote:
> > 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm2/
> > 
> > 
> > - Added the mlock and !SCHED_OTHER Linux Security Module for the audio guys.
> >   It seems that nothing else is going to come along and this is completely
> >   encapsulated.
> 
> Even if we accept a module that grants capabilities to groups this isn't fine
> yet because it only supports two specific capabilities (and even those two in
> different ways!) instead of adding generic support to bind capabilities to
> groups.

I'm sure that got discussed somewhere in the 1000 emails which flew past
last time.  Jack?

