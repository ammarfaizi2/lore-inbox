Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbRGZCZv>; Wed, 25 Jul 2001 22:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbRGZCZk>; Wed, 25 Jul 2001 22:25:40 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:63241 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S267552AbRGZCZ2>;
	Wed, 25 Jul 2001 22:25:28 -0400
From: tpepper@vato.org
Date: Wed, 25 Jul 2001 19:25:33 -0700
To: corbet-lk@lwn.net
Cc: linux-kernel@vger.kernel.org
Subject: TASK_EXCLUSIVE?
Message-ID: <20010725192533.A17850@cb.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I was reading through the new edition of Linux Device Drivers and decided to
try the TASK_EXCLUSIVE flag to get a single member of a wait queue to wake.  I
get a compile error though that it is undeclared.  Grepping the kernel source
came up with nothing.

Did something change before the book went to press?  I seem to recall reading
something here about that but can't come up with anything searching the
archives.  Maybe I'm just misremembering.  At any rate it seems to have gone
somewhere...can somebody point me at its replacement?  Does WQ_FLAG_EXCLUSIVE
do the job?

Tim
