Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUJGVVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUJGVVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUJGVSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:18:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:40087 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S267904AbUJGVEh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:04:37 -0400
Message-ID: <4165AD8B.9020207@austin.ibm.com>
Date: Thu, 07 Oct 2004 15:56:43 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux ppc64; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
References: <20041007015139.6f5b833b.akpm@osdl.org>
In-Reply-To: <20041007015139.6f5b833b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - sparc64 and ppc64 successfully compile again.
>
ppc64 defconfig doesn't compile for me.

drivers/video/aty/radeon_monitor.c: In function `radeon_parse_montype_prop':
drivers/video/aty/radeon_monitor.c:77: error: parse error before "else"
make[3]: *** [drivers/video/aty/radeon_monitor.o] Error 1
make[2]: *** [drivers/video/aty] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

