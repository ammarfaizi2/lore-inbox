Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbTI2Kwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 06:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTI2Kwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 06:52:55 -0400
Received: from [134.153.36.129] ([134.153.36.129]:56525 "EHLO
	hardcopy.esd.mun.ca") by vger.kernel.org with ESMTP id S262973AbTI2Kwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 06:52:54 -0400
From: Stephen Anthony <stephena@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: Possible regression with 2.6.0-test6
Date: Mon, 29 Sep 2003 08:22:09 -0230
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309290822.09859.stephena@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that test6 isn't as 'smooth' as test5.  Specifically, if I 
open an nedit window and use the cursor down key to scroll down through 
text, there is some jerkiness.  At this point I've noticed that CPU use 
goes to 1% or more.  A similar problem happens with Opera (web browser), 
but of course the CPU usage is higher, which is expected.

When I go back to test5, scrolling in nedit is smoother, and CPU never 
goes above 0.6%.  Note that the speed that text moves is the same in 
both, but the test6 version 'jumps' and 'stops' for a little bit.  Hence 
my describing it as jerky.

I know its not much to go on, but it is a noticable difference, at least 
to me.  Since this new release has tweaked interactivity patches, I'm 
wondering if this has anything to do with it.

System is a fully updated Mandrake 9.1, but I don't think that would 
matter.  CPU is P4-2.4GHz with 768 MB RAM, and NVidia video card.

Steve
