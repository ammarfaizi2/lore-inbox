Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTKITWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTKITWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:22:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:9448 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262775AbTKITWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:22:24 -0500
Date: Sun, 9 Nov 2003 11:26:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com, alan@lxorguk.ukuu.org.uk
Subject: Re: Some thoughts about stable kernel development
Message-Id: <20031109112604.613d385d.akpm@osdl.org>
In-Reply-To: <m3u15de669.fsf@defiant.pm.waw.pl>
References: <m3u15de669.fsf@defiant.pm.waw.pl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> wrote:
>
> There is a problem that a development cycle (time between stable
>  = non-pre/rc versions) is long. Imagine a situation when we are at
>  some pre-3 stage, the kernel tree is full of problems which must be
>  resolved before the final release, and some serious security-class
>  bug has been found.

Well yes.  Two days after 2.4.20 was released we discovered a
data-corrupting bug in ext3.  I had no means of delivering a fix for that
apart from sticking a bunch of patches on my web page and making a lot of
noise about it.

So there is a case for a "2.4.20-post1" release to address such things.
