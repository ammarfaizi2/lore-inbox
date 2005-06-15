Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVFOIOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFOIOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 04:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVFOIOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 04:14:33 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:47991 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261312AbVFOIOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 04:14:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ElX7otMMS9DwEm+6jC5FuCD7dP5KlJy2yz9F+0ghiWEPgL05hrjAB71j/cq2Pv00KQ9pWnxPhyzD7Vq7tYpPrhZoMpzmgE2FX9xh8YuwcgBTZxhTZfAkchPyy46iGNG0dFzxnIbNjg3IWhjQ0tTHvpURqRuJhNxXqmlj+IhjnWs=
Message-ID: <42AFE410.4020803@gmail.com>
Date: Wed, 15 Jun 2005 16:17:20 +0800
From: Roy Lee <roylee17@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: zh-tw, en-us, en, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: One question about fork, vfork and clone
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm a kernel newbie and are reading the source code about process
management of kernel-2.11.10
I found it has not only the sys_clone() but also three explict syscalls
in the arch/<ARCH>/kernel/process.c

sys_fork(), sys_vfork(), sys_clone()

is this means the library calls no more wrap the sys_clone() for the
three library call(fork,vfork,clone), but
call the corresponding syscall? or it never did that?

I've also downloaded the source code of glibc-2.3.5, but I'm not
sure where I should I start to figure out this.

Thank you for your reply.

Roy
