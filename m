Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUHZDyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUHZDyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 23:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267407AbUHZDyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 23:54:24 -0400
Received: from jsc-ems-vws02.jsc.nasa.gov ([139.169.16.51]:48914 "EHLO
	JSC-EMS-VWS02.jsc.nasa.gov") by vger.kernel.org with ESMTP
	id S266560AbUHZDyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 23:54:23 -0400
Message-ID: <A850C6B3EB02F044907B475259FFF56501724A18@jsc-mail08.jsc.nasa.gov>
From: "HOLTZ, CORBIN L. (JSC-ER) (LM)" <corbin.l.holtz1@jsc.nasa.gov>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Disable kscand/Normal?
Date: Wed, 25 Aug 2004 22:54:20 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry to post to the list without being subscribed, but I've searched the
web for information on this and I can't find anything useful.  I'm currenty
building a realtime visualization system for a Space Shuttle landing
simulator at NASA.  I'm using a small network of 5 Pentium 4 computers
running RedHat's 2.4.20-31.9 kernel.  I'm easily running 60 frames/second on
my systems, but I'm having a problem because the kscand/Normal thread comes
in every 25 seconds and causes me to drop a frame (very annoying).  I've
looked into the kernel source and found where the kscand threads are
spawned.  I also see where the 25 second period is coming from.  What I'm
wondering is what would happen if I disabled the kscand/Normal thread?  I've
got plenty of memory, and my process is the only thing running on the
system.  Would I eventually see problems, or would I be OK since I'm not
running low on memory?  What if I modified the kernel to allow me to
temporarily disable the thread while my application is running (using a
/proc file or something similar)?  Sorry if this is a bad question, but I
figure the people on this list are the best source of info.

Please CC: me directly since I'm not subscribed to the list. 

Thanks for any help or suggestions,
Corbin
corbin.l.holtz@jsc.nasa.gov

