Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTKREjB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 23:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTKREjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 23:39:01 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:38024 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S261947AbTKREi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 23:38:59 -0500
Message-ID: <3FB9A261.7080500@mcve.com>
Date: Mon, 17 Nov 2003 23:38:57 -0500
From: Brad House <brad@mcve.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, Brad House <brad_mssw@gentoo.org>
Subject: Re: forcedeth: version 0.17 available
References: <3FB807A3.8010207@gmx.net> <3FB98C18.8090305@gmx.net>
In-Reply-To: <3FB98C18.8090305@gmx.net>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the problem I saw was with the 2.6 patch.

These lines:

+++ build-2.6/drivers/net/forcedeth.c	2003-11-15 23:00:30.000000000 +0100
@@ -0,0 +1,1416 @@

Should be

+++ build-2.6/drivers/net/forcedeth.c	2003-11-15 23:00:30.000000000 +0100
@@ -0,0 +1,1418 @@


Otherwise, the last 2 lines:
+module_init(init_nic);
+module_exit(exit_nic);

Get cut off.

-Brad


Carl-Daniel Hailfinger wrote:
> Carl-Daniel Hailfinger wrote:
> 
>>version 0.17 of forcedeth for Linux 2.4 and 2.6 is available at
>>http://www.hailfinger.org/carldani/linux/patches/forcedeth/
> 
> 
> The patches for Linux 2.4 were malformed. Corrected versions have been
> uploaded a few hours ago.
> Thanks to Brad House for spotting this.
> 
> 
> Regards,
> Carl-Daniel
> 
> 


