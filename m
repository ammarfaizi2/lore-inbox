Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbULMMVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbULMMVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbULMMVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:21:08 -0500
Received: from em.njupt.edu.cn ([202.119.230.11]:7662 "HELO njupt.edu.cn")
	by vger.kernel.org with SMTP id S262237AbULMMVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:21:05 -0500
Message-ID: <302943559.21891@njupt.edu.cn>
X-WebMAIL-MUA: [10.10.136.115]
From: "Zhenyu Wu" <y030729@njupt.edu.cn>
To: linux-kernel@vger.kernel.org
Date: Mon, 13 Dec 2004 21:12:39 +0800
Reply-To: "Zhenyu Wu" <y030729@njupt.edu.cn>
X-Priority: 3
Subject: about kernel_thread!
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I have some confusions on kernel_thread, so I want to get help.

I want to create a thread in a loadable module, then I used the function
kernel_thread() in init_module(). Of course, the thread was created, but when I
remove the module there are errors. I think it is because of the thread I have
created that have not been killed. So, how can I kill this thread when I remove
the module?

Thanks,


