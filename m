Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317497AbSGOOmG>; Mon, 15 Jul 2002 10:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSGOOmA>; Mon, 15 Jul 2002 10:42:00 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:43465 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317497AbSGOOl6> convert rfc822-to-8bit; Mon, 15 Jul 2002 10:41:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [Announce] device-mapper beta3 (fast snapshots)
Date: Mon, 15 Jul 2002 09:39:15 -0500
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
References: <3D2F6464.60908@us.ibm.com> <20020715085954.GB3432@fib011235813.fsnet.co.uk>
In-Reply-To: <20020715085954.GB3432@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207150939.15138.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 July 2002 03:59, Joe Thornber wrote:
> Andrew,
>
> On Fri, Jul 12, 2002 at 06:21:08PM -0500, Andrew Theurer wrote:
> > Thanks for the results.  I tried the same thing, but with the latest
> > release (beta 4) and I am not observing the same behavior.  Your results
> > show very little difference in performance when using different chunk
> > sizes for snapshots, but I observed a range of 10 to 24 seconds for this
> > same test on beta4 (I have also included EVMS 1.1 pre4):
>
> I must admit your results are strange to say the least, the only
> explanation that I can think of at the moment is that you have been
> running LVM1.
>
> Just to reassure me that this is not the case, can you please make
> sure that the LVM1 driver is not available, and that your path are not
> picking up old LVM1 tools by mistake.  There was a time when the tools
> were installed in /usr/sbin rather than /sbin.

Joe, 

I assure you this is not LVM1.  I have both tools installed, but they are 
under different directories, and my test scripts call them with full paths.  
I have also done some tracing to verify I am in device-mapper code.  Also, 
the kernel I tested with has only device mapper and evms, no lvm1. 

-Andrew Theurer
