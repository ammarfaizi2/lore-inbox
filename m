Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbTDOM6E (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTDOM6E 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:58:04 -0400
Received: from mx02.cyberus.ca ([216.191.240.26]:35345 "EHLO mx02.cyberus.ca")
	by vger.kernel.org with ESMTP id S261165AbTDOM6D 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:58:03 -0400
Date: Tue, 15 Apr 2003 09:09:05 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Tomas Szepe <szepe@pinerecords.com>
cc: linux-kernel@vger.kernel.org, "" <netdev@oss.sgi.com>
Subject: Re: [PATCH] qdisc oops fix
Message-ID: <20030415084706.O1131@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Pass those net patches to the maintainers (not Alan, not Linus, not
Marcello) and CC netdev (optionally cc lk)?

I dont understand why

-       sch = kmalloc(size, GFP_KERNEL);
+       sch = kmalloc(size, GFP_ATOMIC);

mysteriously fixes the problem? Could the problem be elsewhere?
Can you repost what the issue was? I am not on lk and i just saw the
posting on a web page.

cheers,
jamal
