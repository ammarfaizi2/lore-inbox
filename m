Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270669AbTGUTVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270671AbTGUTVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:21:45 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:57572 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S270669AbTGUTVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:21:43 -0400
Message-ID: <3F1CA198.2040603@netcabo.pt>
Date: Tue, 22 Jul 2003 03:29:44 +0100
From: Pedro Ribeiro <deadheart@netcabo.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: driver error in mm2 compilation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jul 2003 19:31:33.0101 (UTC) FILETIME=[B12701D0:01C34FBE]
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

