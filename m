Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVKSNTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKSNTz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 08:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVKSNTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 08:19:55 -0500
Received: from post.pl ([212.85.96.51]:974 "HELO v00051.home.net.pl")
	by vger.kernel.org with SMTP id S1750702AbVKSNTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 08:19:55 -0500
Message-ID: <437F267A.9030206@post.pl>
Date: Sat, 19 Nov 2005 14:19:54 +0100
From: Marcin Garski <mgarski@post.pl>
Reply-To: mgarski@post.pl
User-Agent: Mozilla Thunderbird 1.0.7 (Linux)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compile warnings in 2.6.14.2 (x86_64)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on replies, I am not subscribed to the list, thanks!]

GCC: gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)
OS: Fedora Core 4 (x86_64)

drivers/md/dm-linear.c: In function ‘linear_ctr’:
drivers/md/dm-linear.c:41: warning: format ‘%lu’ expects type ‘long 
unsigned int *’, but argument 3 has type ‘sector_t *’

drivers/md/dm-linear.c: In function ‘linear_status’:
drivers/md/dm-linear.c:91: warning: format ‘%lu’ expects type ‘long 
unsigned int’, but argument 5 has type ‘sector_t’

drivers/md/dm-stripe.c: In function ‘get_stripe’:
drivers/md/dm-stripe.c:54: warning: format ‘%lu’ expects type ‘long 
unsigned int *’, but argument 3 has type ‘sector_t *’

drivers/md/dm-stripe.c: In function ‘stripe_status’:
drivers/md/dm-stripe.c:198: warning: format ‘%lu’ expects type ‘long 
unsigned int’, but argument 5 has type ‘sector_t’

drivers/md/dm-stripe.c:200: warning: format ‘%lu’ expects type ‘long 
unsigned int’, but argument 5 has type ‘sector_t’

drivers/md/dm-crypt.c: In function ‘crypt_ctr’:
drivers/md/dm-crypt.c:656: warning: format ‘%lu’ expects type ‘long 
unsigned int *’, but argument 3 has type ‘sector_t *’

drivers/md/dm-crypt.c:661: warning: format ‘%lu’ expects type ‘long 
unsigned int *’, but argument 3 has type ‘sector_t *’

drivers/md/dm-crypt.c: In function ‘crypt_status’:
drivers/md/dm-crypt.c:903: warning: format ‘%lu’ expects type ‘long 
unsigned int’, but argument 4 has type ‘sector_t’

drivers/md/dm-crypt.c:903: warning: format ‘%lu’ expects type ‘long 
unsigned int’, but argument 6 has type ‘sector_t’

drivers/usb/input/yealink.c: In function ‘usb_probe’:
drivers/usb/input/yealink.c:909: warning: format ‘%d’ expects type 
‘int’, but argument 4 has type ‘long unsigned int’

lib/ts_kmp.c:125: warning: initialization from incompatible pointer type

lib/ts_bm.c:165: warning: initialization from incompatible pointer type

lib/ts_fsm.c:318: warning: initialization from incompatible pointer type
-- 
Marcin Garski
