Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261979AbTCQWaX>; Mon, 17 Mar 2003 17:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbTCQWaX>; Mon, 17 Mar 2003 17:30:23 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:27477 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S261979AbTCQWaW>; Mon, 17 Mar 2003 17:30:22 -0500
Message-ID: <3E75D0C2.4020502@myrealbox.com>
Date: Mon, 17 Mar 2003 13:42:26 +0000
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.64-ac4 compilation error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/mpparse.c: In function `get_smp_config':
arch/i386/kernel/mpparse.c:658: `pc98' undeclared (first use in this function)
arch/i386/kernel/mpparse.c:658: (Each undeclared identifier is reported only once
arch/i386/kernel/mpparse.c:658: for each function it appears in.)
make[1]: *** [arch/i386/kernel/mpparse.o] Error 1
make: *** [arch/i386/kernel] Error 2

I have a single-processor athlon machinel.  The .config file contains
these entries in the kernel-hacking section which seems odd:
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y


