Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318741AbSIDBeK>; Tue, 3 Sep 2002 21:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318757AbSIDBeK>; Tue, 3 Sep 2002 21:34:10 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:43455 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S318741AbSIDBeJ>; Tue, 3 Sep 2002 21:34:09 -0400
Message-ID: <3D7563B2.2090707@linux.org>
Date: Tue, 03 Sep 2002 21:36:50 -0400
From: John Weber <john.weber@linux.org>
Organization: Linux Online
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux on Toshiba Libretto 70CT
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel locks up completely whenever I launch any particularly large 
application under X (xterm is fine, netscape locks up the box).
I've confirmed that this isn't just X locking up, as the machine is 
completely frozen (doesn't respond to pings, doesn't respond to three 
finger salute, etc).

Just to make sure that this isn't a VM/Memory problem:
I've run (and the machine passed) memtest86.
I've tried running X with swapoff (and the machine still locks up).

- Kernel 2.4.19
- GLIBC 2.2.90
- XFree86 4.2.0

I can reproduce this error every single time I run X.  However, I have 
not been able to see the problem on the shell.

Anyone ever see this problem?  Does anyone have pointers on how I can 
better troubleshoot the problem?

