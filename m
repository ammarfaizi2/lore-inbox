Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbUBVAbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 19:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbUBVAbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 19:31:13 -0500
Received: from babyruth.hotpop.com ([38.113.3.61]:29138 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S261632AbUBVAbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 19:31:10 -0500
Date: Sun, 22 Feb 2004 11:27:01 +0530
From: John Levin <levin@gamebox.net>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: module ref count and functions
Message-Id: <20040222112701.2683d1e7.levin@gamebox.net>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	My lsmod gives the following output.

Module                  Size  Used by
cdc_acm                11040  3 
usbcore               112084  4 cdc_acm

1) I would like to know which functions are increasing the reference
count of cdc_acm ? How do i find it out for some other module whose
reference count is being increased? Any place where i can find it. 
2)Which devices are using cdc_acm ?
3)Which applications are increasing the reference count of cdc_acm and
usb_core ?

--

