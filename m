Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268161AbUH3ShO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268161AbUH3ShO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUH3Sab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:30:31 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:28573 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268711AbUH3SZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:25:11 -0400
Date: Mon, 30 Aug 2004 14:24:40 -0400
From: Jeff Kinz <jkinz@kinz.org>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Summarizing the PWC driver questions/answers
Message-ID: <20040830142440.A25964@redline.comcast.net>
References: <20040827162613.GB32244@kroah.com> <20040830173157.GA24392@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040830173157.GA24392@top.worldcontrol.com>; from brian@worldcontrol.com on Mon, Aug 30, 2004 at 10:31:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 10:31:57AM -0700, Brian Litzinger wrote:
> > Q: Why did you remove the hook from the pwc driver?
> > A: It was there for the explicit purpose to support a binary only
> >    module.  That goes against the kernel's documented procedures, so I
> >    had to take it out.

> I think Greg "chose" to take it out.

True, No one was holding a gun to his head.   :)

> > it really didn't belong in there due to the kernel's policy of such
> > hooks. So, once I became aware of it, I had no choice but to remove
> > it.

> I do not believe he "had no choice".  The guards at Auswitchs made the
> same argument at Nuremberg.  

[*** Nice "subtle" technique to call someone a Nazi. Real smooth!]

I "choose" to stop at stop signs and red lights.   Yay me.

> I disagree.  Binary drivers may take away from Linux and they may add to it.

My experiences: Binary drivers make Linux harder to support, harder to
distribute, harder to administrate and harder to maintain in production.

While they provide short term benefits, their long term impact is
negative. One example: What happens when company X goes out of business
or stops supporting the device?

A decision has been made: My understanding is that the Binary portion is 
moving to user space and the devices in question will still function
as a result.   

Please move it off the kernel list.

-- 
Idealism:  "Realism applied over a longer time period"

Jeff Kinz
