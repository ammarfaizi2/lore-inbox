Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVGEVt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVGEVt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVGEVrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:47:17 -0400
Received: from adsl-67-39-48-196.dsl.milwwi.ameritech.net ([67.39.48.196]:51376
	"EHLO mail.wit.org") by vger.kernel.org with ESMTP id S261971AbVGEVjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:39:01 -0400
Message-ID: <42CAFF09.4000406@linuxmachines.com>
Date: Tue, 05 Jul 2005 14:43:37 -0700
From: Jeff Carr <jcarr@linuxmachines.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Hien Nguyen <hien@us.ibm.com>, Jim Keniston <jkenisto@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>
Subject: kprobe support for memory access watchpoints
References: <42CAB369.5020901@linuxmachines.com>
In-Reply-To: <42CAB369.5020901@linuxmachines.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if there are plans to support a method to register
watchpoints for memory data access with kprobe. On x86, it's possible to
watch for read/write access to arbitrary memory locations via DR memory
registers.

Perhaps register_kprobe() could be modified to support this or perhaps
some new function. This would probably be difficult based on how
differently kprobe works vs. how the DR registers work. I thought I
would send an email because you might be doing or thinking something
similar.

Enjoy,
Jeff
