Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUG1RmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUG1RmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267369AbUG1RmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:42:17 -0400
Received: from watson.wustl.edu ([128.252.233.1]:56265 "EHLO watson.wustl.edu")
	by vger.kernel.org with ESMTP id S267348AbUG1RjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:39:00 -0400
Message-ID: <4107E4B3.6070904@watson.wustl.edu>
Date: Wed, 28 Jul 2004 12:38:59 -0500
From: Richard Wohlstadter <rwohlsta@watson.wustl.edu>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dma problems with Serverworks CSB5 chipset
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.6; VAE: 6.26.0.10; VDF: 6.26.0.49; host: watson.wustl.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have 200 servers in a cluster running vanilla kernel 2.4.26(not 
tainted).  Under heavy I/O activity I have various servers completely 
lose access to their IDE bus.  Logs show the same error every time:

hda: dma_timer_expiry: dma status == 0x61

The kernel resets the IDE bus at this point.  Sometimes things start 
working again but mostly all ide access is lost and I have to reboot the 
server.  The chipset is:

  00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)

I have searched archives for problems with this chipset and I have seen 
other users with this same issue, but no resolution to the problem.  Is 
there a known problem with this chipset version or could there be some 
issues still with the serverworks driver?  Any help would be much 
appreciated.  Thanks.

Rich Wohlstadter
modi@swbell.net
