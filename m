Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVAKVlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVAKVlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVAKVgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:36:10 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:56806 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262876AbVAKVeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:34:05 -0500
Date: Tue, 11 Jan 2005 13:34:00 -0800
From: Greg KH <greg@kroah.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Luca Falavigna <dktrkranz@gmail.com>, vamsi_krishna@in.ibm.com,
       prasanna@in.ibm.com, suparna@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kprobes /proc entry
Message-ID: <20050111213400.GB18422@kroah.com>
References: <41E2AC82.8020909@gmail.com> <20050110181445.GA31209@kroah.com> <1105479077.17592.8.camel@pants.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105479077.17592.8.camel@pants.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 03:31:17PM -0600, Nathan Lynch wrote:
> On Mon, 2005-01-10 at 12:14, Greg KH wrote:
> > On Mon, Jan 10, 2005 at 05:25:38PM +0100, Luca Falavigna wrote:
> > > This simple patch adds a new file in /proc, listing every kprobe which
> > > is currently registered in the kernel. This patch is checked against
> > > kernel 2.6.10
> > 
> > No, please do not add extra /proc files to the kernel.  This belongs in
> > /sys, as it has _nothing_ to do with processes.
> 
> Wouldn't this sort of thing be a good candidate for debugfs?  If you're
> messing with kprobes, then aren't you by definition doing kernel
> debugging? :)

That's an even better idea, I like it.

greg k-h
