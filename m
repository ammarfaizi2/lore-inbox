Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267313AbSLKVmB>; Wed, 11 Dec 2002 16:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbSLKVmB>; Wed, 11 Dec 2002 16:42:01 -0500
Received: from email.careercast.com ([216.39.101.233]:50127 "HELO
	email.careercast.com") by vger.kernel.org with SMTP
	id <S267313AbSLKVl7>; Wed, 11 Dec 2002 16:41:59 -0500
Subject: PS/Top broken - /proc entry bad
From: Matt Simonsen <matt_lists@careercast.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 13:49:51 -0800
Message-Id: <1039643391.27406.41.camel@mattsworkstation>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a box where ps and top quit working after hundreds of days uptime.
After doing an strace ps I found that one directory in /proc was hanging
it up, a directory named a 5 digit number which I believe was
associtated with a process of the same name.

I tried doing a kill -9 on the process, it returned fine but the process
was still there. Reboot hung my session, too, I had to use reboot -f to
get the machine healthy again.

Is there any way to "fix" /proc other than what I did? I suppose maybe
going into a lower init level and then back to 3 may have worked. It's a
remote machine, though, so reboot was at the time seemed like a better
solution.

Any comments/suggestions on what to do in this situation?

Thanks
Matt


