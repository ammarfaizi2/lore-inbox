Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268909AbTGTXE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268893AbTGTXE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:04:58 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:25986 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268836AbTGTXEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:04:48 -0400
Message-ID: <3F1B8447.1090401@netcabo.pt>
Date: Mon, 21 Jul 2003 07:12:23 +0100
From: Pedro Ribeiro <deadheart@netcabo.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Error Compiling mm2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jul 2003 23:14:38.0626 (UTC) FILETIME=[B1224820:01C34F14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this error when I try to compile mm2:

drivers/video/riva/fbdev.c: In function `rivafb_cursor':
drivers/video/riva/fbdev.c:1525: warning: passing arg 2 of 
`move_buf_aligned' from incompatible pointer type
drivers/video/riva/fbdev.c:1525: warning: passing arg 4 of 
`move_buf_aligned' makes pointer from integer without a cast
drivers/video/riva/fbdev.c:1525: too few arguments to function 
`move_buf_aligned'
drivers/video/riva/fbdev.c:1527: warning: passing arg 2 of 
`move_buf_aligned' from incompatible pointer type
drivers/video/riva/fbdev.c:1527: warning: passing arg 4 of 
`move_buf_aligned' makes pointer from integer without a cast
drivers/video/riva/fbdev.c:1527: too few arguments to function 
`move_buf_aligned'
make[3]: *** [drivers/video/riva/fbdev.o] Error 1
make[2]: *** [drivers/video/riva] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

PR

