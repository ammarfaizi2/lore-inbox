Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVIDE0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVIDE0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 00:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVIDE0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 00:26:47 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:25645 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750826AbVIDE0q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 00:26:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nhy73HhKAXDAWSLBH4mDZ99Gvn2DP2j2b8w47gw9Kks4NrwwNmL76TCWD6ewKvlH2dw8Pto5/IhGobXUOE3RMQH4PwodlTafymD8lkdBzgKZXFtZEfCPOVdwm+2+wEju6N4y9zodY9tvFhlqvd516rnT2xXALfIXMtZejVj7Jww=
Message-ID: <d2a0e906050903212678ad88a1@mail.gmail.com>
Date: Sun, 4 Sep 2005 12:26:42 +0800
From: Petter Shappen <shappen@gmail.com>
Reply-To: shappen@gmail.com
To: linux-kernel@vger.kernel.org
Subject: threads questions
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,this is my first time to post a message on this mailing-list.
As we all know the kernel maintain a data struct for the
process(PCB),and also for the thread.Because of the latter's smaller
than the former's,thread switching is faster than the process
switching.And from the book,I read that threads shares some data
information of the process,so my question is that when the threads of
different processes have to switch,and the threads also use some data
of the processes,will the process switch  before the threads?The speed
of these threads switching is slower than normal,is that true ?
How can the thread's advantage over process reflect?

-- 
Support Open Source!
Support Linux (Debian Mandriva ...)!
You are free to use them!
