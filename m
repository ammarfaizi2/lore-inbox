Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVIVUrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVIVUrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVIVUrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:47:39 -0400
Received: from c3po.0xdef.net ([217.172.181.57]:56974 "EHLO c3po.0xdef.net")
	by vger.kernel.org with ESMTP id S1751169AbVIVUri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:47:38 -0400
Date: Thu, 22 Sep 2005 22:47:37 +0200
From: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>
To: linux-kernel@vger.kernel.org
Subject: Re: security patch
Message-ID: <20050922204737.GA5267@0xdef.net>
Mail-Followup-To: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>,
	linux-kernel@vger.kernel.org
References: <20050922194433.13200.qmail@webmail2.locasite.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050922194433.13200.qmail@webmail2.locasite.com.br>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* breno@kalangolinux.org | 2005-09-22 19:44:33 [-0000]:

>I'm doing a new feature for linux kernel 2.6 to protect against all kinds of buffer
>overflow. It works with new sys_control() system call controling if a process can or can't
>call a system call ie. sys_execve();

[...]

>Questions .. suggestions.

Think about userspace loaders! E.g. John Reiser's UPX or technics used in
self[0]. What about "protect against all kinds of buffer overflow", at
least the aplication can still be crash.

>Breno at kalangolinux.org 

HGN

[0] http://www.phrack.org/show.php?p=63&a=11
