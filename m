Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTIEGbX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 02:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbTIEGbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 02:31:23 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:15621 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261329AbTIEGbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 02:31:21 -0400
From: Michael Frank <mhf@linuxmail.org>
To: brian@worldcontrol.com, Patrick Mochel <mochel@osdl.org>
Subject: Re: swsusp: revert to 2.6.0-test3 state
Date: Fri, 5 Sep 2003 13:53:02 +0800
User-Agent: KMail/1.5.2
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
References: <20030904115824.GD24015@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain> <20030905041316.GA1886@top.worldcontrol.com>
In-Reply-To: <20030905041316.GA1886@top.worldcontrol.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309051353.02837.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 12:13, brian@worldcontrol.com wrote:
> On Thu, Sep 04, 2003 at 08:25:38AM -0700, Patrick Mochel wrote:
> > No, you have to understand that I don't want to call software_suspend()
> > at all. You've made the choice not to accept the swsusp changes, so we're
> > forking the code. We will have competing implementations of
> > suspend-to-disk in the kernel.
>
> And the fork happened in 2.6.0-test4?
>
> Some how I thought the 6, being even, meant stable.

Yes _without_ -test it's stable, with -test it its still testing...

>
> I am at a complete loss how these test3 to test4 major changes
> that broke everything meet with the often repeated definitions
> of how kernel development is to be accomplished.

It did not break anything but historic dysfunctional - I know 
because I tested several releases between 2.5.6x and 2.6-test1. 

>
> Perhaps I missed something, development kernels include all
> odd numbers and 6?

You look at it very black and white. If you like to insist, please 
consider the recall of a tire on some SUV which kept on flipping over
as an example of fixing something in a less than ideal manner. If it
is broken, it must be fixed to protect and satisfy.

Of course, I remember that some people say it wasn't the tire but the 
suspension being too hard which resulted in recommending low-inflation
of the tire. This turned out to be under-inflation in practice, leading 
to the tire to fail due to mechanical over-stress and over-heating... 
Poor tire - other tyres survive this kind of abuse by the typical 
consumer every day. ;)

Regards
Michael


