Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbUASAnm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 19:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUASAnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 19:43:41 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:47117 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S264311AbUASAnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 19:43:39 -0500
Date: Sun, 18 Jan 2004 18:57:28 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: xscreensaver and kernel 2.6.x
Message-ID: <20040118235728.GF9456@widomaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Microsoft Loves You!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm trying to find the details on why xscreensaver has some troubles
with the 2.6 kernels.

On my system, something in pam is failing, causing a several seconds
delay when unlocking my screen.

In /var/log/messages, I get this:

Jan 18 17:59:07 daydream xscreensaver(pam_unix)[869]: authentication
failure; logname= uid=1000 euid=1000 tty=:0.0 ruser= rhost= user=shannon
Jan 18 17:59:09 daydream xscreensaver(pam_unix)[869]: authentication
failure; logname= uid=1000 euid=1000 tty=:0.0 ruser= rhost=  user=root

This happens with all 2.6 kernels, and all earlier kernels work fine.

I found a lot of references to problems with pam and the 2.5 and 2.6
kernels, but can't seem to find the details I want.

Any help appreciated.

I don't get lockups, but the delay is annoying, and I hate broken
things.


-- 
UNIX/Perl/C/Pizza____________________s h a n n o n@wido !SPAM maker.com
