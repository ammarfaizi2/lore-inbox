Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbUJWP7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUJWP7M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 11:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUJWP7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 11:59:12 -0400
Received: from mail.linicks.net ([217.204.244.146]:7428 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261217AbUJWP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 11:59:07 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.x: nfs warning: mount version older than kernel
Date: Sat, 23 Oct 2004 16:59:01 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410231659.01882.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this.  My NFS server is an old 486 box running 2.0.26 kernel and god 
know what version NFS server (can't be bothered to telnet in at the mo).

I started getting this after moving the client from 2.4.x -> 2.6.x

Oct 23 13:46:44 Linux233 kernel: nfs warning: mount version older than kernel
Oct 23 13:46:44 Linux233 kernel: RPC: call_verify: program 100003, version 3 
unsupported by server 486Linux
Oct 23 13:46:44 Linux233 kernel: RPC: call_verify: program 100003, version 3 
unsupported by server 486Linux
Oct 23 13:46:44 Linux233 kernel: nfs warning: mount version older than kernel

It's a strange warning, and hard to read what it is really saying.

All works OK though...

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
