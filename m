Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTJMWWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbTJMWWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 18:22:48 -0400
Received: from relaydal.nai.com ([205.227.136.197]:51405 "EHLO
	RelayDAL.nai.com") by vger.kernel.org with ESMTP id S262037AbTJMWWq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 18:22:46 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [INFO] gcc versions used to compile a kernel
Date: Mon, 13 Oct 2003 15:22:44 -0700
Message-ID: <613FA566484CA74288931B35D971C77E0366FF@losexmb1.corp.nai.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [INFO] gcc versions used to compile a kernel
Thread-Index: AcORlJVVbDgc6I5iQzSCW6xnMvJPiwAQ8lRw
From: <Andrew_Purtell@NAI.com>
To: <spi@gmxpro.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Oct 2003 22:23:24.0827 (UTC) FILETIME=[9E1E86B0:01C391D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the particulars of your distribution, you might need to
upgrade your binutils:

   ftp://ftp.gnu.org/pub/gnu/binutils


Andrew Purtell                             SMTP: andrew_purtell@nai.com
Network Associates Laboratories

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Sebastian Piecha
Sent: Monday, October 13, 2003 7:15 AM
To: linux-kernel@vger.kernel.org
Subject: [INFO] gcc versions used to compile a kernel


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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
