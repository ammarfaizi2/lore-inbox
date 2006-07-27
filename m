Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWG0UT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWG0UT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWG0UT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:19:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18115 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750708AbWG0UT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:19:58 -0400
Message-ID: <44C91FEC.1020309@redhat.com>
Date: Thu, 27 Jul 2006 16:19:56 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: patch for Documentation/initrd.txt?
References: <200607272026.57695.a1426z@gawab.com>
In-Reply-To: <200607272026.57695.a1426z@gawab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Tom Horsley wrote:

>> +Compressed cpio images

> OT, but your docPatch made me think of another way to init the kernel; via 
> tmpfs, i.e. initTmpFS.
> 
> Can anybody see how that could be useful?

That is exactly what Tom describes, except it is called initramfs
and goes into ramfs - which is mostly the same as tmpfs.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
