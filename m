Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbUB2Uzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 15:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbUB2Uzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 15:55:49 -0500
Received: from mail.gmx.de ([213.165.64.20]:55515 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262139AbUB2Uzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 15:55:48 -0500
X-Authenticated: #1226656
Date: Sun, 29 Feb 2004 21:55:46 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: kernel unaligned acc on Alpha
Message-Id: <20040229215546.065f42e9.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a lot of unaligned accesses in kernel space:

kernel unaligned acc    : 2191330
(pc=fffffffc002557d8,va=fffffffc00256059)

It seems to be located in the networking part (iptables?) from the
kernel. Can someone please help me how to find the location of these
uac's? I already have recompiled the kernel with debugging enabled and
tried to debug it with gdb. 

Another question: What's the meaning of va?

Thank you very much!

Regards

Marc

