Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRHWWMl>; Thu, 23 Aug 2001 18:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270624AbRHWWMb>; Thu, 23 Aug 2001 18:12:31 -0400
Received: from wet-pants.ximian.com ([141.154.95.105]:7296 "EHLO wet-pants")
	by vger.kernel.org with ESMTP id <S270619AbRHWWMX>;
	Thu, 23 Aug 2001 18:12:23 -0400
Subject: mmap() return value when length == 0
From: jacob berkman <jacob@ximian.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 23 Aug 2001 18:12:54 -0400
Message-Id: <998604774.796.10.camel@wet-pants>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

on linux (2.4.9 and 2.2.18), the mmap() syscall will return NULL if the
length argument is 0 rather than returning MAP_FAILED (-1).  this is
different than both solaris and hp-ux, and the linux man page doesn't
indicate that it should do this.

so, is this indeed the desired behaviour or a longstanding bug?

thanks,
jacob

