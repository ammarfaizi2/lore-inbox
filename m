Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268556AbRHBTCc>; Thu, 2 Aug 2001 15:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268598AbRHBTCW>; Thu, 2 Aug 2001 15:02:22 -0400
Received: from dc-mxdb05.hsacorp.net ([209.225.8.79]:26779 "EHLO
	dc-mxdb05.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S268556AbRHBTCH>; Thu, 2 Aug 2001 15:02:07 -0400
From: "Gerald Walden" <thepond@charter.net>
Subject: 8259A Edge or Level Triggered?
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.4.5
Date: Thu, 02 Aug 2001 15:06:57 -0400
Message-ID: <web-919724@dc-mxdb05.cluster1.charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:

I am writing a driver for an x86 based machine.  The
platform is a "standard" PC with a bios etc...

If I install an interrupt handler, how do I know how the
8259A is programmed by default?  Is it edge or level
triggered?  If I want to change the default, how do I do it?

I've been pouring through the kernel code looking for device
initialization code for the PIC, and I cannot find an area
where specific command bytes are sent to the PIC with  the
exception of the EOI, and the setup of the interrupt vector
table.

Please let me know if there is a more appropriate list to
send this type of question to.

Kindest Regards,

Jerry
