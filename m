Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUCaVWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbUCaVWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:22:15 -0500
Received: from [199.72.170.146] ([199.72.170.146]:10187 "HELO
	thebrittinggroup.com") by vger.kernel.org with SMTP id S261239AbUCaVWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:22:14 -0500
Message-ID: <44574.64.25.5.177.1080768515.squirrel@webmail.thebrittinggroup.com>
Date: Wed, 31 Mar 2004 16:28:35 -0500 (EST)
Subject: mem=options changed in 2.6.x?
From: "Casey Allen Shobe" <cshobe@osss.net>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Compaq Proliant 5000 with 320Mb RAM.

If I boot up either linux 2.4.22 or 2.6.4, it only identifies 12Mb of memory.

With 2.4.22, the kernel parameters "mem=exactmap mem=640k@0M mem=319M@1M"
worked to make the kernel identify all of the memory.

I have tried the same with linux 2.6.4, but with the above flags the
kernel will not boot.  With "mem=320M", the system boots, but it still
thinks it has only 12Mb RAM.

Something I'm missing or did this change between releases?

Thanks in advance,

-- 
Casey Allen Shobe
Open Source Software Solutions
cshobe@osss.net
