Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTLGTzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 14:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTLGTzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 14:55:40 -0500
Received: from www.mesos.de ([213.221.94.209]:3265 "EHLO mesos.de")
	by vger.kernel.org with ESMTP id S264505AbTLGTzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 14:55:39 -0500
Message-ID: <3FD38633.BC0DDBA4@mesos.de>
Date: Sun, 07 Dec 2003 20:57:39 +0100
From: Ralf Dreibrodt <rd@mesos.de>
Organization: Mesos
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Performance-Problem (CPU) since 2.4.23
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i have two servers with performance-problems since the last update to
2.4.23.

In the meanwhile i have the following informations from the first
server:

CPU:
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz

After a fresh Reboot with the old Kernel, 2.4.22 (there is nobody beside
me logged in), the Apache takes exact 5 Seconds CPU time until the first
child is started.
After a fresh Reboot with the new Kernel, the Apache takes 60-70 Seconds
CPU time until the first child is started.

I took the .config-file from 2.4.22 to compile the 2.4.23.
I have selected P4 and 386, it didn't changed anything.

Where can be the problem?
Are there others with the same problem?
The second server has a Duron-CPU, but the same problem.

Regards,
Ralf Dreibrodt

PS: Please CC to me, because i am not on the list.
