Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTIYSBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTIYSBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:01:41 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:28431 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261702AbTIYSAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:00:33 -0400
Date: Thu, 25 Sep 2003 20:00:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>,
       Ronald Bultje <rbultje@ronald.bitfreak.net>,
       linux-kernel@vger.kernel.org
Subject: Re: linux/time.h annoyance
Message-ID: <20030925180017.GA2089@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ronald Bultje <rbultje@ronald.bitfreak.net>,
	linux-kernel@vger.kernel.org
References: <1064483200.6405.442.camel@shrek.bitfreak.net> <20030925105436.A8809@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925105436.A8809@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 10:54:37AM +0100, Christoph Hellwig wrote:
> On Thu, Sep 25, 2003 at 11:48:01AM +0200, Ronald Bultje wrote:
> > Hi,
> > 
> > I'm annoyed by something in linux/time.h. The issue is as follows:
> > 
> > -
> > #include <sys/time.h>
> > #include <linux/time.h>
> > int main () { return 0; }
> 
> So don't include it.  Userspace should use <sys/time.h>, not kernel
> headers.

What about the patch that Matthew Wilcox posted?
Was it too late or was it not the right solution for separating
headers to be exposed to user space, and kernel internal headers?

	Sam
