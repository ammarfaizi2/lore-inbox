Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTKZHSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 02:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTKZHSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 02:18:24 -0500
Received: from lieber-annanas-als-annatrocken.de ([213.133.103.207]:20405 "EHLO
	lieber-annanas-als-annatrocken.de") by vger.kernel.org with ESMTP
	id S262115AbTKZHSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 02:18:23 -0500
From: Jens Gutzeit <jens@gutzeit.at>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: boot problems since test9
Date: Wed, 26 Nov 2003 08:17:53 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311260817.56310.jens@gutzeit.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have some problems with the test series since test9. (except test9-bk21).

I compiled my kernel with all support that I need and it worked perfectly, 
then I had upgraded to test9 and the system won't boot, I get no error 
message on startup except the few lines from my boot loader, few days after 
that I had tried test9-bk21 and it started working again. And now test10 
fails again. Even debug and initcall_debug gaves no output.

I had tried a bit around this night and the system won't boot if I compile it 
for AMD-k6 2/3 CPUs (I have a AMD-k6 2 450), it works perfectly if I compile 
it for 386. The .config was the same for all versions I had tried.

I don't think this is a compiler problem since test8 and test9-bk21 worked. 
Anyone an idea what could cause this? Is this a known bug or s.th. similar?

My gcc version is:

gcc version 3.3.2 20031022 (Gentoo Linux 3.3.2-r2, propolice)

If you need more information please ask, I will try to get the information you 
need.

My .config is online at http://gutzeit.at/kernel.config
I'm using test10-bk1 at the moment.

Thanks in advance,
Jens Gutzeit

