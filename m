Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTJ0FOq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 00:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTJ0FOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 00:14:46 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:20384 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262782AbTJ0FOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 00:14:44 -0500
Date: Sun, 26 Oct 2003 21:14:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: kl@vsen.dk
Subject: [Bug 1428] New: 3c59x won't work at all with 2.6.0-test	kernels
Message-ID: <600810000.1067231679@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=1428

           Summary: 3c59x won't work at all with 2.6.0-test kernels.
    Kernel Version: 2.6.0-test4-mmX to 2.6.0-test8-mm1
            Status: NEW
          Severity: blocking
             Owner: jgarzik@pobox.com
         Submitter: kl@vsen.dk


Distribution: Gentoo Linux
Hardware Environment: IBM Thinkpad X20 - miniPCI 3com network:
lspci with 2.4.22 kernel:
 00:0a.0 Ethernet controller: 3Com Corporation 3c556B Hurricane CardBus (rev 20)

Software Environment:
glibc-2.3.2, gcc-3.2.3 - anything else? 
Problem Description:
My 3c59x miniPci network card won't work at all with 2.6.0-test kernels.I think
I've seen it work once, with an old 2.6.0-test kernel, but I'm not sure, and
I've tried all the way back to 2.6.0-test3, and can't reproduce it (working that
is).
the Hardware mac address is set to all FF's on 2.60. ifconfig works fine - I
just can't ping anything.

with 2.4.22 it all works like a charm.

Steps to reproduce:
compile 2.6.0-testX with 3c59x as module or built-in.


