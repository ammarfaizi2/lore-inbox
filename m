Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264150AbUDRUsA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 16:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUDRUsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 16:48:00 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:34462 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S264150AbUDRUr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 16:47:59 -0400
Message-ID: <4082E97D.10605@verizon.net>
Date: Sun, 18 Apr 2004 16:47:57 -0400
From: "Anthony R." <russo.lutions@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, ja
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: linux-kernel@vger.kernel.org,
       ReiserFS Mailing List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] ReiserFS I/O error Handling [was Re: kernel BUG at fs/reiserfs/prints.c:339!
 kernel 2.6.5]
References: <407FF7CA.3050002@verizon.net> <4080573C.4090709@suse.com>
In-Reply-To: <4080573C.4090709@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [162.84.206.17] at Sun, 18 Apr 2004 15:47:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Mahoney wrote:

> It's most definately a hardware problem. It could be your disk, your
> controller, or the cable connecting them, but somehow hdb1 started
> getting I/O errors. One of them just happened to be in the journal area,
> which ReiserFS doesn't handle well at the moment; it just panics, which
> is what you saw.


FYI, I did an extensive HW test from the vendor and all tests passed.
So I'm not sure it's definitely a HW problem.

I will check out the patches though, thanks.

-- tony

