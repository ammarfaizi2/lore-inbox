Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268766AbUILST6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268766AbUILST6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUILST6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:19:58 -0400
Received: from the-village.bc.nu ([81.2.110.252]:21685 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268766AbUILSTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:19:49 -0400
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)
	Denial of Service Attack
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Wolfpaw - Dale Corse <admin@wolfpaw.net>, peter@mysql.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <20040912175946.GA3491@alpha.home.local>
References: <029201c498d8$dff156f0$0300a8c0@s>
	 <001c01c498df$8d2cd0f0$0200a8c0@wolf>
	 <20040912175946.GA3491@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095009440.11736.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Sep 2004 18:17:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-12 at 18:59, Willy Tarreau wrote:
> The problem is within inetd. In my case it could be because it was a bit
> old (1999), but since you have it too,

Ancient inetd had several fd leak bugs fixed over time and some other
problems with built in services. Not much of a suprise that a 1999 inetd
has it.

Alan

