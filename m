Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbTIVRqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTIVRqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:46:10 -0400
Received: from mail.ncsa.uiuc.edu ([141.142.2.28]:22757 "EHLO
	mail.ncsa.uiuc.edu") by vger.kernel.org with ESMTP id S261284AbTIVRqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:46:08 -0400
X-Envelope-From: hjafri@ncsa.uiuc.edu
Message-Id: <5.1.0.14.2.20030922124433.0748c478@mail.ncsa.uiuc.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 22 Sep 2003 12:46:07 -0500
To: linux-kernel@vger.kernel.org
From: "Hassan M. Jafri" <hjafri@ncsa.uiuc.edu>
Subject: TCP connections dropped
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.19
glibc 2.2.5

I am running a parallel program on 170 nodes, with 2 processes on each
nodes. so 340 total processes. Each process has a TCP connection
established with every other process. So each process has 339 sockets in
ESTABLISHED state. The problem occurs when I try to write() on these
socket. The TCP connection gets dropped for some of the sockets of a few
processes as soon as they try to write to those socket. This problem,
however, does not occur, if I reduce the number of processes to less than
306 (305 TCP sockets/connections for each process).

Any ideas why connections are getting dropped?

-Hassan

