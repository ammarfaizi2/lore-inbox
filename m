Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286127AbSAEA2E>; Fri, 4 Jan 2002 19:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286137AbSAEA1z>; Fri, 4 Jan 2002 19:27:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3337 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286127AbSAEA1n>; Fri, 4 Jan 2002 19:27:43 -0500
Subject: Re: kernel log messages using wrong timezone
To: cfriesen@nortelnetworks.com (Chris Friesen)
Date: Sat, 5 Jan 2002 00:38:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C360D22.F6FFFAD6@nortelnetworks.com> from "Chris Friesen" at Jan 04, 2002 03:14:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Meqn-0006E8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How does the kernel figure out how to timestamp the log output?  The reason I'm
> asking is that we have a system that has /etc/localtime pointing to the
> Americas/Montreal timezone, but the log output from the kernel appears to be
> UTC.

The kernel doesn't timestamp, the logging daemon syslogd/klogd does. Now
if the daemon is running UTC because your distribution starts it before
setting the timezones up that might cause wrong zones
