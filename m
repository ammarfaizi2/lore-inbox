Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTELV7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTELV7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:59:47 -0400
Received: from smtp5.wanadoo.es ([62.37.236.237]:4287 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S262824AbTELV7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:59:44 -0400
Message-ID: <3EC01A86.4010402@wanadoo.es>
Date: Tue, 13 May 2003 00:04:54 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       marcelo <marcelo@conectiva.com.br>
Subject: Re: [PATCH] kbuild and CONFIG_PROC_FS bug
References: <3EBDA545.4010603@wanadoo.es> <20030512212704.GX1107@fs.tum.de>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>>diff -Nuar linux/arch/alpha/config.in linux.xose/arch/alpha/config.in
>>--- linux/arch/alpha/config.in  2003-05-11 02:53:23.000000000 +0200
>>+++ linux.xose/arch/alpha/config.in     2003-05-11 02:59:04.000000000 +0200
>>@@ -287,7 +287,7 @@
>> bool 'System V IPC' CONFIG_SYSVIPC
>> bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
>> bool 'Sysctl support' CONFIG_SYSCTL
>>-if [ "$CONFIG_PROC_FS" = "y" ]; then
>>+if [ "$CONFIG_PROC_FS" != "n" ]; then
>>...
> 
> 
> CONFIG_PROC_FS is a bool, I don't see anything that changes with your 
> patch.

read this: http://marc.theaimsgroup.com/?l=linux-kernel&m=104948236128373&w=2
it is _necessary_, Roman aka kbuild guru said it.
But if you have other idea...

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!

