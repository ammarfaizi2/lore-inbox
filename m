Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284244AbRLFUdN>; Thu, 6 Dec 2001 15:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284206AbRLFUc6>; Thu, 6 Dec 2001 15:32:58 -0500
Received: from alpha.zapmedia.com ([64.94.5.4]:48609 "EHLO
	maximus.zapmedia.com") by vger.kernel.org with ESMTP
	id <S284237AbRLFUcS>; Thu, 6 Dec 2001 15:32:18 -0500
Date: Thu, 6 Dec 2001 15:32:04 -0500
From: Shawn Veader <shawn.veader@zapmedia.com>
To: linux-kernel@vger.kernel.org
Subject: Incorrect LEADOUT on mixed CDs...
Message-ID: <20011206203204.GB8441@maximus.zapmedia.com>
Reply-To: Shawn Veader <shawn.veader@zapmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I seem to have run into a problem with the way the LEADOUT
information is calculated for CDs in the Linux kernel.
After spending much time trying to track down the source of my
problem in our own code, I began looking at other projects to
see how they report the time on a CD. By running several different
programs I discovered that they too report the wrong time for
the last track of an enhanced/mixed CD. They seem to be consistently
about 2 min and 30 sec off or roughly 11250 frames off. I've 
checked the source of several different apps and they all seem
to do it the same way. I've also verified this as far back as
2.2.14 and all the way up to 2.4.13. (sorry haven't had time to
roll me a new kernel yet...) If someone could point me to where
I can find informatoin on how to fix the CD driver or if the
current maintainer could verify that I'm not a total idiot,
I would greatly appreciate it. Thanks!

I am not subscribed to the mailing list so if there are
responces, please forward them onto me as well. Thanks again
for your time.
-- 
shawn veader        --oOo--      linux os developer
shawn.veader@zapmedia.com | http://www.zapmedia.com
