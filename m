Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTFPWiW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTFPWiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:38:22 -0400
Received: from [62.75.136.201] ([62.75.136.201]:4587 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264398AbTFPWiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:38:13 -0400
Message-ID: <3EEE4A14.4090505@g-house.de>
Date: Tue, 17 Jun 2003 00:52:04 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.71 compile error on alpha
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i have an alpha here, running 2.5.70 for weeks now. the patch to 2.5.71
applied with no errors (i did "make clean" before this) but it won't
compile:

# make vmlinux modules modules_install

...

   CC      arch/alpha/kernel/srmcons.o
arch/alpha/kernel/srmcons.c:269: warning: `srmcons_ops' defined but not used
make[2]: *** [arch/alpha/kernel/srmcons.o] Error 1
make[1]: *** [arch/alpha/kernel] Error 2
make: *** [vmlinux] Error 2
------------

compiler is gcc3.3, .config did not change (new options in 2.5.71 with
"No" answered).

Thanks,
Christian.

