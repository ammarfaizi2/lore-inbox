Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbUK0DoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUK0DoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUK0DoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:44:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262703AbUKZTfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:52 -0500
Subject: Re: [PATCH] Work around for periodic do_gettimeofday hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101314988.1714.194.camel@mulgrave>
References: <1101314988.1714.194.camel@mulgrave>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101397634.18177.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 25 Nov 2004 15:47:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-24 at 16:49, James Bottomley wrote:
> On the voyager systems particularly (but also on some of my slower
> parisc boxes) I periodically get hangs where the system just seems to
> stop (although it does remain able to execute alt-sysrq).  The traces
> always seem to implicate do_gettimeofday in the xtime seqlock.

What are the other CPUs doing in this case ?

