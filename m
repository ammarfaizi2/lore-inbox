Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTLGRQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbTLGRQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:16:34 -0500
Received: from smtp12.eresmas.com ([62.81.235.112]:20187 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S264456AbTLGRQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:16:33 -0500
Message-ID: <3FD3603A.6020907@wanadoo.es>
Date: Sun, 07 Dec 2003 18:15:38 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Additional clauses to GPL in network drivers
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

> "This file is not a complete program and may only be used when the
> entire operating system is licensed under the GPL".

to be more exact, it would have to say:

This file is not a complete program and may only be used when the
entire *derived work* is licensed under the GPL *version XX*

Or if you want be pedantic:

---cut---
   NOTE! This copyright does *not* cover user programs that use kernel
 services by normal system calls - this is merely considered normal use
 of the kernel, and does *not* fall under the heading of "derived work".
 Also note that the GPL below is copyrighted by the Free Software
 Foundation, but the instance of code that it refers to (the Linux
 kernel) is copyrighted by me and others who actually wrote it.

 Also note that the only valid version of the GPL as far as the kernel
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever), unless explicitly otherwise stated.
--end---
where '_this_' is linux/COPYING

BTW, there is in Kernel Janitor TODO list [1] an item to
place a GPL head on all source files.

Maybe, now that Torvalds is boring and waiting for akpm.
He could do this job ;-)

[1] http://alumno.inacap.cl/kj-wiki/bin/view/KJ/ToDo

