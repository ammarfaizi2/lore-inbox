Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271327AbTGQQj0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271338AbTGQQjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:39:03 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:26719 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S271327AbTGQQhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:37:43 -0400
Message-ID: <3F16D39A.4020805@myrealbox.com>
Date: Fri, 18 Jul 2003 00:49:30 +0800
From: Romit Dasgupta <romit@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Documentation error in arch/i386/boot/setup.S ??
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     Is the following comment in arch/i386/boot/setup.S correct?

> # jump to startup_32 in arch/i386/kernel/head.S
> #
> # NOTE: For high loaded big kernels we need a
> #       jmpi    0x100000,__BOOT_CS
> #


Should it not be
# jump to startup_32 in arch/i386/boot/compressed/head.S
in case of compressed kernels?

Please correct me if I am wrong.

Regards,
-Romit


