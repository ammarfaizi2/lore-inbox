Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTLVOuH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 09:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTLVOuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 09:50:07 -0500
Received: from shadow02.cubit.at ([80.78.231.91]:18842 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S264366AbTLVOuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 09:50:04 -0500
Subject: /proc/meminfo values
From: Andreas Unterkircher <unki@netshadow.at>
Reply-To: unki@netshadow.at
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1072104601.1165.33.camel@winsucks>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 15:50:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.

one question, didn't find any other information souce.

in kernel 2.4 /proc/meminfo writes back exactly mem info values
in the first 2 lines like:

cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  244191232 238395392  5795840        0  2732032 138403840
Swap: 509923328 147443712 362479616


but with 2.6 it looks like they have been removed. where can i get the
exactly free memory (+ swap) from the kernel so i havn't to use the
kb-values which i get back from /proc/meminfo?

i try to check the source good from "free" (with the -b option it
returns the bytes-value) which seems to simple multiply *1024 to
the kb values.


thanks for any info!

greetings, andi

