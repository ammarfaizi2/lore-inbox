Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283932AbRLAFQz>; Sat, 1 Dec 2001 00:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283933AbRLAFQg>; Sat, 1 Dec 2001 00:16:36 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:52233 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283932AbRLAFQ1>; Sat, 1 Dec 2001 00:16:27 -0500
Message-ID: <3C0867A3.5119D2BC@zip.com.au>
Date: Fri, 30 Nov 2001 21:16:19 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: war <war@starband.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is it normal for freezing while...
In-Reply-To: <3C085B04.50ABE0B5@starband.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war wrote:
> 
> Is it normal for a system to lockup while creating a 3GB test file?
> 

Seems that way.

It also seems that yesterday I sent you the URL of two patches:

http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/vm-fixes.patch
http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/elevator.patch

and I explicitly asked you to report on the result of applying them?

If you apply them, you'll find that the problem goes away. If you're
using ext3, you'll get better results if you mount with the `noatime'
option.

So please - test the patches, report the results.  It's how things
work around here.  Sometimes :)

Thanks.

-
