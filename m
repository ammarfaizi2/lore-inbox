Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbTDNAf3 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 20:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTDNAf3 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 20:35:29 -0400
Received: from granite.he.net ([216.218.226.66]:21508 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262682AbTDNAf2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 20:35:28 -0400
Date: Sun, 13 Apr 2003 17:49:26 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>, Alistair Strachan <alistair@devzero.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm2
Message-ID: <20030414004926.GA23762@kroah.com>
References: <200304132059.11503.alistair@devzero.co.uk> <20030413130543.081c80fd.akpm@digeo.com> <1050266723.767.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050266723.767.1.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 04:45:24PM -0400, Robert Love wrote:
> On Sun, 2003-04-13 at 16:05, Andrew Morton wrote:
> 
> > It's a bk bug.  This might make it boot:
> 
> Yah, I needed a similar patch to make 2.5.67-mm2 boot.  Not sure if its
> hiding the real problem or not, but it works.

This patch is just hiding the real problem.  The real problem is in the
input class patch that I sent to Linus.  Either the input core needs to
be marked as a subsys_init(), or that patch needs to be reverted.

I'll work on fixing this up on Monday...

greg k-h
