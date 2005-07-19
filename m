Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVGSRII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVGSRII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 13:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGSRII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 13:08:08 -0400
Received: from mail.yosifov.net ([193.200.14.114]:16772 "EHLO home.yosifov.net")
	by vger.kernel.org with ESMTP id S261532AbVGSRIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 13:08:07 -0400
Subject: Noob question. Why is the for-pentium4 kernel built with
	-march=i686 ?
From: Ivan Yosifov <ivan@yosifov.net>
Reply-To: ivan@yosifov.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 19 Jul 2005 20:07:32 +0300
Message-Id: <1121792852.11857.6.camel@home.yosifov.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

If I set the CPU type to be amd64 in kernel config, the kernel is built
with -march=k8. If I set it to be k6, the kernel is built with
-march=k6. If I set the CPU type to be Pentium4, the kernel is built
with -march=i686 -mtune=pentium4. Why is not the for-P4 kernel built
with -march=pentium4 ? 
I tried building the kernel with -march=pentium4  for the sake of
experiment and got no ill effects.

Thanks,
Ivan Yosifov.

