Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbUK3TW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbUK3TW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbUK3TWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:22:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:5022 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262261AbUK3TWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:22:24 -0500
Subject: Re: patch RTAI (fusion-0.6.4) with kernel 2.6.9 on Fedora Core 3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Yihan Li <Yihan.Li@Edgewater.CA>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <000901c4d70c$0ecf1bd0$8500a8c0@WS055>
References: <000901c4d70c$0ecf1bd0$8500a8c0@WS055>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101838736.25617.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 18:18:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 18:40, Yihan Li wrote:
> Help needed!
> I am trying to patch RTAI (fusion-0.6.4) with kernel 2.6.9 on Fedora Core 3.
> The following steps are what I was following:

You don't want base 2.6.9 anyway because it has lots of bad bugs in it
and security holes. It also won't compile with a modern gcc.

One fix is to unpack the Fedora Core 3 update kernel which is 2.6.9 +
some
bits of -ac + other fixes, and then apply it to that. The changes are
fairly
small so it probably will work especially if you drop the 4G/4G patch
out.

Otherwise you can get collections of 2.6.9 fix patches from the 2.6.9-ac
tree
and two or three others.

