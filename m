Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTDRCr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 22:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbTDRCr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 22:47:26 -0400
Received: from smtp3.starband.net ([148.78.247.24]:39874 "EHLO
	hestia.email.starband.net") by vger.kernel.org with ESMTP
	id S262776AbTDRCr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 22:47:26 -0400
Date: Thu, 17 Apr 2003 23:03:02 -0400
From: Jason Giglio <jgiglio@netmar.com>
To: linux-kernel@vger.kernel.org
Subject: Sockets hanging in CLOSING state for hours
Message-Id: <20030417230302.2e4db816.jgiglio@netmar.com>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having trouble with sockets hanging in CLOSING state when lmule,
which was listening on the port, crashes.  This prevents lmule from
binding to the port upon restart.  I have confirmed that no part of the
program is still running. 

The socket stays hung in this state for up to several hours, and I can't
figure out any way to force the socket to close. (Though I suppose
rebooting would do it)

A search of the archive turned up a similar problem ages ago with
Sendmail on kernel 2.1.

Kernel is Red Hat 2.4.18-19.8.0

Please CC all replies.

Thanks,
Jason
