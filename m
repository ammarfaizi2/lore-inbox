Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTIYKXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTIYKXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:23:30 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:49677 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261797AbTIYKX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:23:28 -0400
Date: Thu, 25 Sep 2003 11:23:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux/time.h annoyance
Message-ID: <20030925112326.A9412@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ronald Bultje <rbultje@ronald.bitfreak.net>,
	linux-kernel@vger.kernel.org
References: <1064483200.6405.442.camel@shrek.bitfreak.net> <20030925105436.A8809@infradead.org> <1064485031.2220.468.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1064485031.2220.468.camel@shrek.bitfreak.net>; from rbultje@ronald.bitfreak.net on Thu, Sep 25, 2003 at 12:17:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 12:17:12PM +0200, Ronald Bultje wrote:
> linux/videodev2.h includes linux/time.h. And I need linux/videodev2.h in
> my application, there is no sys/ equivalent. I expect there's more of
> such cases.
> 
> I also explained this in my first email. ;).

So fix your copy of linux/videdev2.h to not include linux/time.h.

If you ask Gerd nicely he might even include that change in the kernel
version so don't have to keep a delta.

