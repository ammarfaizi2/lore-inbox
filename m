Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTD0VLW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 17:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTD0VLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 17:11:22 -0400
Received: from mail2.ewetel.de ([212.6.122.20]:16089 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S261804AbTD0VLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 17:11:21 -0400
Subject: Kernel 2.4.18smp and 2.4.20smp: Lockup on unloading module 'hisax'.
From: Stefan Brozinski <Stefan.Brozinski@gmx.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Not organized
Message-Id: <1051478611.1785.11.camel@arcadia>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Apr 2003 23:23:31 +0200
Content-Transfer-Encoding: 7bit
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI.

Having inserted extra debugging output in modprobe/insmod, I can see
that

  delete_module("hisax")

is called but never returns.


A similar problem has been observed in kernel 2.2.19pre10:
http://lists.insecure.org/linux-kernel/2001/Feb/2494.html


Good luck,
Stefan


-- 
Stefan Brozinski <Stefan.Brozinski@gmx.net>
[Not subscribed to lkml. Please CC me if you have any questions]


