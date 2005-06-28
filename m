Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVF1CTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVF1CTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 22:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVF1CT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 22:19:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:10196 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262261AbVF1CTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 22:19:22 -0400
Message-ID: <42C0B39E.7070509@pobox.com>
Date: Mon, 27 Jun 2005 22:19:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: cfq build breakage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In latest git tree...

   CC [M]  drivers/block/cfq-iosched.o
drivers/block/cfq-iosched.c: In function `cfq_put_queue':
drivers/block/cfq-iosched.c:303: sorry, unimplemented: inlining failed 
in call to 'cfq_pending_requests': function body not available
drivers/block/cfq-iosched.c:1080: sorry, unimplemented: called from here
drivers/block/cfq-iosched.c: In function `__cfq_may_queue':
drivers/block/cfq-iosched.c:1955: warning: the address of 
`cfq_cfqq_must_alloc_slice', will always evaluate as `true'
make[2]: *** [drivers/block/cfq-iosched.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2
