Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTIYKyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTIYKyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:54:16 -0400
Received: from mail2.uu.nl ([131.211.16.76]:37522 "EHLO mail2.uu.nl")
	by vger.kernel.org with ESMTP id S261784AbTIYKyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:54:15 -0400
Subject: Re: linux/time.h annoyance
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Christoph Hellwig <hch@infradead.org>, Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
In-Reply-To: <20030925112326.A9412@infradead.org>
References: <1064483200.6405.442.camel@shrek.bitfreak.net>
	 <20030925105436.A8809@infradead.org>
	 <1064485031.2220.468.camel@shrek.bitfreak.net>
	 <20030925112326.A9412@infradead.org>
Content-Type: text/plain
Message-Id: <1064487333.2228.475.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 12:55:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[CC to v4l/Gerd then]

On Thu, 2003-09-25 at 12:23, Christoph Hellwig wrote:
> On Thu, Sep 25, 2003 at 12:17:12PM +0200, Ronald Bultje wrote:
> > linux/videodev2.h includes linux/time.h. And I need linux/videodev2.h in
> > my application, there is no sys/ equivalent. I expect there's more of
> > such cases.
>  
> So fix your copy of linux/videdev2.h to not include linux/time.h.
> 
> If you ask Gerd nicely he might even include that change in the kernel
> version so don't have to keep a delta.

Hm, makes sense... Gerd, could you please remove linux/time.h from
linux/videodev2.h?

Thanks,
Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

