Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTFJF7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 01:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTFJF7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 01:59:51 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:6651 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262383AbTFJF7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 01:59:50 -0400
Subject: Oops during boot when init USB mouse, 2.5.70-bk14
From: Martin Schlemmer <azarah@gentoo.org>
To: KML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055224690.5281.224.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 10 Jun 2003 07:58:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am getting the following during mouse/keyboard is initialized,
but it seems to be more specific to the mouse.  Both are USB.
It was fine with last 2.5.69 kernel, but started when i switched
to 2.5.70-bk12 (have not tried vanilla, or earlier 2.5.70 bk's,
as swamped at work).  NB: there are no oops 'header'.

-------------
Trace; c01a9466 <kobject_get+4c/4e>
Trace; c0201830 <get_device+18/21>
Trace; c0203001 <class_device_add+132/137>
Trace; c0202ec2 <class_device_initialize+16/23>
Trace; fc8a5478 <_end+3c3d5234/3fb2ddbc>
Trace; fc8ab682 <_end+3c3db43e/3fb2ddbc>
Trace; fc895d06 <_end+3c3c5ac2/3fb2ddbc>
Trace; fc895d2f <_end+3c3c5aeb/3fb2ddbc>
Trace; fc898f58 <_end+3c3c8d14/3fb2ddbc>
Trace; fc898edc <_end+3c3c8c98/3fb2ddbc>
Trace; fc898e60 <_end+3c3c8c1c/3fb2ddbc>
Trace; fc89488b <_end+3c3c4647/3fb2ddbc>
Trace; c0129ddb <__call_usermodehelper+0/65>
Trace; fc8ab15b <_end+3c3daf17/3fb2ddbc>
Trace; fc898edc <_end+3c3c8c98/3fb2ddbc>
Trace; fc898e78 <_end+3c3c8c34/3fb2ddbc>
Trace; fc898e60 <_end+3c3c8c1c/3fb2ddbc>
Trace; fc89e07c <_end+3c3cde38/3fb2ddbc>
Trace; fc898e20 <_end+3c3c8bdc/3fb2ddbc>
Trace; fc898e78 <_end+3c3c8c34/3fb2ddbc>
Trace; c02023b3 <bus_match+45/73>
Trace; fc898e78 <_end+3c3c8c34/3fb2ddbc>
Trace; fc898ea8 <_end+3c3c8c64/3fb2ddbc>
Trace; fc8b3efc <_end+3c3e3cb8/3fb2ddbc>
Trace; c0202424 <device_attach+43/72>
Trace; fc898e78 <_end+3c3c8c34/3fb2ddbc>
Trace; fc8b3ea0 <_end+3c3e3c5c/3fb2ddbc>
Trace; c02025a6 <bus_add_device+64/ae>
Trace; c02017c7 <device_add+cd/fb>
Trace; fc89f2f9 <_end+3c3cf0b5/3fb2ddbc>
Trace; fc8ab1c8 <_end+3c3daf84/3fb2ddbc>
Trace; fc8a10d8 <_end+3c3d0e94/3fb2ddbc>
Trace; fc8a1508 <_end+3c3d12c4/3fb2ddbc>
Trace; fc8a15a5 <_end+3c3d1361/3fb2ddbc>
Trace; c0119541 <default_wake_function+0/2e>
Trace; fc8b3fc0 <_end+3c3e3d7c/3fb2ddbc>
Trace; fc8b3fc0 <_end+3c3e3d7c/3fb2ddbc>
Trace; fc8a157b <_end+3c3d1337/3fb2ddbc>
Trace; c0108999 <kernel_thread_helper+5/b>



-- 
Martin Schlemmer


