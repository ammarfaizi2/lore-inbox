Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUGEVjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUGEVjB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 17:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUGEVjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 17:39:01 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:1697 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261169AbUGEVi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 17:38:59 -0400
X-OB-Received: from unknown (208.36.123.30)
  by wfilter.us4.outblaze.com; 5 Jul 2004 21:37:28 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "surfing t" <surf17@lycos.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 05 Jul 2004 16:38:58 -0500
Subject: Points to fs architecture
X-Originating-Ip: 195.249.184.145
X-Originating-Server: ws7-1.us4.outblaze.com
Message-Id: <20040705213858.2002086AE1@ws7-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to create a utility that "hooks" into the the filesystem. What I want to do is to be able to review
all file system read/write/seek requests, most of the time without affecting file system operation (ie after
review the request is passed on to the entity that would have received it had my utility not been installed, however
some of the requests my driver should handle itself. My problem is that while I have first-hand experience on kernel
programming I have never done anything on a UNIX og Linux kernel and I only know its structure from a user-level
perspective. Where can I find documentation on how to code drivers for the Linux kernel and about how the entire
file system works (by "file system" I don't refer to ext3 or reiserfs or anything like that - I mean the architecture that allows all these things to co-exist). I want my driver to be at a level above things like ext3/reiserfs if possible. Basically I just want to "hijack" the system calls that applications use to access files and then pass them on to the original system call. Is this possible and how do I do it? Any help will be greatly appreciated and the utility I have in mind will benefit the entire community (I will GPL it of course) and I believe it could so some extent make Linux more popular. I am a bit secretive right now because I really want to implement this idea myself. I will give credit to those who responds to this message.

Thank you in advance!
-- 
_______________________________________________
Find what you are looking for with the Lycos Yellow Pages
http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10

