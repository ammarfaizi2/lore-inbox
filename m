Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270352AbTHQPwq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 11:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270354AbTHQPwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 11:52:46 -0400
Received: from imsm083.netvigator.com ([218.102.48.167]:30028 "EHLO
	imsm083dat.netvigator.com") by vger.kernel.org with ESMTP
	id S270352AbTHQPwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 11:52:45 -0400
X-Mailer: Openwave WebEngine, version 2.8.10.1 (webedge20-101-191-105-20030415)
From: Sum <ellenyip@netvigator.com>
To: <linux-kernel@vger.kernel.org>
Subject: About 2.6.0-test3
Date: Sun, 17 Aug 2003 23:52:41 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Message-Id: <20030817155241.HXW9561.imsm083dat.netvigator.com@imailmta.netvigator.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've got the following problem when I make modules with the 2.6.0-test3 version

CC [M]  drivers/char/riscom8.o
In file included from drivers/char/riscom8.c:51:
drivers/char/riscom8.h:88: field `tqueue' has incomplete type
drivers/char/riscom8.h:89: field `tqueue_hangup' has incomplete type
drivers/char/riscom8.c:84: warning: type defaults to `int' in
declaration of `DECLARE_TASK_QUEUE'
drivers/char/riscom8.c:84: warning: parameter names (without types) in
function
declaration
drivers/char/riscom8.c: In function `rc_paranoia_check':
drivers/char/riscom8.c:143: warning: implicit declaration of function
`kdevname'drivers/char/riscom8.c:143: warning: format argument is not a
pointer (arg 2)
drivers/char/riscom8.c:147: warning: format argument is not a pointer
(arg 2)
drivers/char/riscom8.c:142: confused by earlier errors, bailing out
make[2]: *** [drivers/char/riscom8.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

I know maybe I have to disable the module, but I don't know which module should I disable. Thanks very much 

