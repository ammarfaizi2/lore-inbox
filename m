Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVL0EvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVL0EvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 23:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVL0EvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 23:51:25 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:4156 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932222AbVL0EvY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 23:51:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=onPSv1hChKwnnN8h4xBon2R3FlkRp7nCXYMuZe0TQtuZQA4xxnI0/FmNWSlYTNG0k7fAqVx7xbaGPlE9IRj1W90Tgc+nxqJffuy6TMMpf5LSHT0Y5ZBp/ACKKHZx4u++qe63TeMyl1zpQzP8A2wHxvHnZh4oDBaPezHQkZUoKio=
Message-ID: <9026964a0512262051m4653c126q4aae75b609c20d2@mail.gmail.com>
Date: Mon, 26 Dec 2005 23:51:23 -0500
From: Yi Wang <wymail@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to get blocking information?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am new to Linux kernel and now working on a project, which tries to
modifies the kernel a little bit and get some blocking information
about system calls. That is, if a system call gets blocked (put into
sleep), I want to know the "reason for sleep" and the "file name &
line number which causes the blocking".

I know that there are data structs in FreeBSD holding these
information, but I don't know if linux has the same facility
(functions / data structs). Hope someone can give me a hint.

Also, I wonder if ru_majflt in struct rusage (linux/resource.c) is
already implemented.

Thanks!
Yi
