Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTLWT1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTLWT1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:27:18 -0500
Received: from peabody.ximian.com ([141.154.95.10]:50148 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262074AbTLWT0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:26:01 -0500
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
From: Rob Love <rml@ximian.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20031223192226.A10239@infradead.org>
References: <20031223002126.GA4805@kroah.com>
	 <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
	 <20031223131523.B6864@infradead.org> <20031223180127.GA14282@kroah.com>
	 <20031223191634.A8914@infradead.org> <1072207183.6015.19.camel@fur>
	 <20031223192226.A10239@infradead.org>
Content-Type: text/plain
Message-Id: <1072207555.6015.22.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 14:25:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 14:22, Christoph Hellwig wrote:

> Well, it's not just for /dev/random but also for all in-kernel cosumers
> of random numbers, so doing this as a sysctl makes quite a lot of sense.

And /dev/random is the user-space abstraction representing the random
number generator... 

> Whether sysctl should be mached into procfs or sysfs or rather be it's
> own fs is an entirely different question.  Interface-wise the latter
> would make most sense.

What to do with sysctl's in the long run is a good question.

	Rob Love


