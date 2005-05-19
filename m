Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVESJSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVESJSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 05:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVESJSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 05:18:38 -0400
Received: from agf.customers.acn.gr ([213.5.17.156]:27526 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP id S262472AbVESJSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 05:18:36 -0400
Message-ID: <009301c55c53$bbcb9710$0101010a@dioxide>
From: "linux" <kernel@wired-net.gr>
To: "lkml" <linux-kernel@vger.kernel.org>
References: <200505132117.37461.arnd@arndb.de> <200505181441.01495.arnd@arndb.de> <20050518202446.GA20041@kroah.com> <200505191029.07970.arnd@arndb.de>
Subject: 2.4 Kernel threads
Date: Thu, 19 May 2005 12:18:35 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i am starting from inside a module a kernel thread*,but in some time later i
want to remove that module.
What is the process while unloading a module to release a kernel thread in
2.4.x kernel series.?????


* kernel_thread(module_thread, &startup, CLONE_KERNEL);

Thanks in advance.

