Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275336AbTHSEjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275332AbTHSEjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:39:52 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:3296 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S275357AbTHSEju
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:39:50 -0400
Message-ID: <3F41AA15.1020802@verizon.net>
Date: Tue, 19 Aug 2003 00:39:49 -0400
From: "Anthony R." <russo.lutions@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cache limit
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [162.84.223.61] at Mon, 18 Aug 2003 23:39:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to tune my kernel not to use as much memory for cache
as it currently does. I have 2GB RAM, but when I am running one program
that accesses a lot of files on my disk (like rsync), that program uses
most of the cache, and other programs wind up swapping out. I'd prefer to
have just rsync run slower because less of its data is cached, rather
than have
all my other programs run more slowly. rsync is not allocating memory,
but the kernel is caching it at the expense of other programs.

With 2GB on a system, I should never page out, but I consistently do and I
need to tune the kernel to avoid that. Cache usage is around 1.4 GB!
I never had this problem with earlier kernels. I've read a lot of comments
where so-called experts poo-poo this problem, but it is real and
repeatable and I am
ready to take matters into my own hands to fix it. I am told the cache
is replaced when
another program needs more memory, so it shouldn't swap, but that is not
the
behaviour I am seeing.

Can anyone help point me in the right direction?
Do any kernel developers care about this?

My kernel is stock 2.4.21, I run Redhat 9 on a 3GHz P4. I'd give you MB
info but I've seen
this behaviour on other motherboards as well.

Thank you very much for your help.

-- tony
"Surrender to the Void." 
-- John Lennon


