Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUJASrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUJASrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUJASry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:47:54 -0400
Received: from mgw-x4.nokia.com ([131.228.20.27]:21993 "EHLO mgw-x4.nokia.com")
	by vger.kernel.org with ESMTP id S266009AbUJASrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:47:53 -0400
X-Scanned: Fri, 1 Oct 2004 21:47:28 +0300 Nokia Message Protector V1.3.31 2004060815 - RELEASE
Date: Fri, 1 Oct 2004 21:47:14 +0300
From: "Teras Timo (EXT-YomiGroup/Helsinki)" <Ext-Timo.Teras@nokia.com>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: kobject events questions
Message-ID: <20041001184714.GA19587@two.research.nokia.com>
References: <415ABA96.6010908@nokia.com> <1096486749.4666.31.camel@betsy.boston.ximian.com> <415D28B7.5070306@nokia.com> <20041001164750.GA11646@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001164750.GA11646@kroah.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 09:47:50AM -0700, ext Greg KH wrote:
> > I'm just a bit dubious about adding new signals since they are hardcoded 
> > in the kernel. It's a time consuming process to add new signals (either 
> > for development build or for official kernels). This is one of the 
> > reasons I liked more about the original kevent patch. Wouldn't simple 
> > #defines have been enough for signal names?
> 
> What's the difference between a #define and a enum?  We want these to be
> well known, and correct.  A enum gives us that.

I was a bit ambiguous. I meant #defines with string literals. That would
have assured correct signal names. I guess to have them all well known
justifies for enums (even though it makes adding new ones a bit more
difficult).

Thanks,
  Timo
