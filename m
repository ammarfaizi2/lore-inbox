Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbUDONE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUDONE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:04:57 -0400
Received: from sea2-f69.sea2.hotmail.com ([207.68.165.69]:58888 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262990AbUDONEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:04:54 -0400
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Make modules and make modules_install :copy all files to /lib/modules/ - newbie
Date: Thu, 15 Apr 2004 16:04:51 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F69TaGmvSVMum000047350@hotmail.com>
X-OriginalArrivalTime: 15 Apr 2004 13:04:51.0432 (UTC) FILETIME=[3D000680:01C422EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am working with 2.4.20 kernel.
I had changed one  driver only . (one source file).
It is the network driver I use. (under /drivers/net)
I type make modules. Evrything is OK: It creates one new .o file.
It was (and still is) a loadable module. (when I type
make menuconfig I see it with <M>).

I perform make_install:
I see that all the modules (*.o files ) are copied to 
/lib/modules/version....

Is there a way that only the relevant file (or files) that were changed will
be copied to /lib/modules/version....  (Except of course copying one by one 
the *.o file/files
that their sources were changed).


regards,
sting

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

