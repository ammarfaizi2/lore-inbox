Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTJMOPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTJMOPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:15:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:34256 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261815AbTJMOPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:15:17 -0400
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: linux-kernel@vger.kernel.org
Date: Mon, 13 Oct 2003 16:15:28 +0200
MIME-Version: 1.0
Subject: [INFO] gcc versions used to compile a kernel
Message-ID: <3F8ACFA0.10239.10815846@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last days I had a lot of trouble getting different kernel 
versions to run. Enclosed is a short report of the experience I made.

First I tried to compile all kernels with gcc 3.3.1.

2.4.20 I even couldn't compile.
2.4.22-ac4 compiled well but oopsed immediately after booting.
2.6.0-test4 and test5 compiled well but didn't boot and froze with a 
blank screen.
2.6.0-test6 compiled well but froze after starting /sbin/init.

Then I used gcc 2.95.3 for compiling 2.4.20, 2.4.22-ac4 and 2.6.0-
test7 and all kernels booted smoothly.

It's seems that at least in my configuration gcc 3.3.1 is doing a bad 
job.

Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

