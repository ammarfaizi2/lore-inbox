Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267329AbUHIWpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267329AbUHIWpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUHIWpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:45:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:45526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267329AbUHIWpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:45:07 -0400
Date: Mon, 9 Aug 2004 15:48:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: jdh <root@hend.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: bsd pts now climbs continuously
Message-Id: <20040809154829.6d39aa45.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.30.0408091609100.31211-200000@link>
References: <Pine.LNX.4.30.0408091609100.31211-200000@link>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jdh <root@hend.net> wrote:
>
> PROBLEM: bsd /dev/pts/n now climbs continuously, ie,
>      15339 pts/103  S+     0:00 rlogin link3

2.6.7 was a long time ago in kernel-time.  In current kernels pty
allocation has gone back to first-fit.  Please retest on 2.6.8-rc3.
