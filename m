Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTIYKPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTIYKPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:15:53 -0400
Received: from mail2.uu.nl ([131.211.16.76]:10384 "EHLO mail2.uu.nl")
	by vger.kernel.org with ESMTP id S261783AbTIYKPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:15:48 -0400
Subject: Re: linux/time.h annoyance
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030925105436.A8809@infradead.org>
References: <1064483200.6405.442.camel@shrek.bitfreak.net>
	 <20030925105436.A8809@infradead.org>
Content-Type: text/plain
Message-Id: <1064485031.2220.468.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 12:17:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-25 at 11:54, Christoph Hellwig wrote:
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

linux/videodev2.h includes linux/time.h. And I need linux/videodev2.h in
my application, there is no sys/ equivalent. I expect there's more of
such cases.

I also explained this in my first email. ;).

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>
Linux Video/Multimedia developer

