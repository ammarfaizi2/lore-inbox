Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbTGHAqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbTGHAqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:46:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:64666 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264980AbTGHAqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:46:08 -0400
Date: Mon, 7 Jul 2003 18:00:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: dwmw2@infradead.org, jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: Re: JFFS2: many compile warnings with gcc 2.95 + kernel 2.5
Message-Id: <20030707180023.0877085e.akpm@osdl.org>
In-Reply-To: <20030708001937.GA6848@fs.tum.de>
References: <20030708001937.GA6848@fs.tum.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
>   CC      fs/jffs2/read.o
>  fs/jffs2/read.c: In function `jffs2_read_dnode':
>  fs/jffs2/read.c:43: warning: unknown conversion type character `z' in format

Switching to %Z will fix that up.
