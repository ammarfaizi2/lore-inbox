Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263165AbVGIHja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbVGIHja (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 03:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbVGIHja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 03:39:30 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:19369 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263158AbVGIHiX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 03:38:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=np4mTiONBQvqDbieCWdu++qKBwcLbHVbFKBBvYBAnWOVX7DUsKXrGVE3lD9lrBV4dROiHkyqDf4xxVSoL9ZIE+xC3ASrnmWNDAefG4VKLrb1KSbosF6c+MFJM342h1cNXC+t1Y7xta1+0k7Xcc1bTTY5ebiUJf+BX4NKdyTYMbY=
Message-ID: <d061968f05070900381c971af2@mail.gmail.com>
Date: Sat, 9 Jul 2005 03:38:20 -0400
From: Scott Ehlert <protonic86@gmail.com>
Reply-To: Scott Ehlert <protonic86@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Memory Page Protections
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently writing a kernel driver dealing with memory interaction
and I'm having an issue with memory protection. I'm trying to figure
out how I can determine the protection set on a page of memory. For
example, with the mprotect syscall I can specify a set of protection
flags in order to change whether a memory page is readable, writable,
and executable or not. I don't want to change the protection. I'd
really just like to query it and figure out what the current
protection is set to for a particular page of memory.

I'd basically be looking for something similar to VirtualQuery from
WinAPI which I believe could give me that sort of information. I'm
just having trouble finding something like that here in Linux. Is
there some system call that I have overlooked?
