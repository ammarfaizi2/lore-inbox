Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSGLOjC>; Fri, 12 Jul 2002 10:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSGLOjB>; Fri, 12 Jul 2002 10:39:01 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:11259 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S316545AbSGLOjA>; Fri, 12 Jul 2002 10:39:00 -0400
Message-ID: <180577A42806D61189D30008C7E632E879398E@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: strange IP stack behavior
Date: Fri, 12 Jul 2002 10:41:43 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running Red Hat 7.2 (Kernel Version 2.4.7-10) and have the following
situation. I am connecting via a LAN switch to approximately 30-40 other
devices. This is an internal network with no external connections. I know
the MAC address of each device that I am communicating with. The
communication is accomplished via UDP/IP. During my application
initialization, I use the SIOCSARP IOCTL to force permanent cache entries
for the devices that I communicate with. The problem that I see is that
sporadically, when I want to transmit the first message to a device, the
destination MAC address is 0. All subsequent messages contain the correct
MAC address. 

Prior to sending any messages, I display the ARP cache and all entries are
there. Does anybody have any idea why this happens? Please CC me directly on
any responses.

Jack Bloch
Siemens Carrier Networks
e-mail    : jack.bloch@icn.siemens.com
phone     : (561) 923-6550

