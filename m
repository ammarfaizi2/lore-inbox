Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbTH3HIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 03:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTH3HIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 03:08:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:9605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261542AbTH3HIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 03:08:46 -0400
Date: Sat, 30 Aug 2003 00:11:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill CONFIG_KCORE_AOUT
Message-Id: <20030830001159.013cc6d2.akpm@osdl.org>
In-Reply-To: <20030830070513.GH7038@fs.tum.de>
References: <200308252332.46101.cijoml@volny.cz>
	<20030826105145.GC7038@fs.tum.de>
	<20030826135323.2c33e697.akpm@osdl.org>
	<20030830070513.GH7038@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> The patch below kills CONFIG_KCORE_AOUT.
> 
>  I've tested the compilation with 2.6.0-test4.

Not on m68knommu or h8300 you haven't :)  They both
select CONFIG_KCORE_AOUT in defconfig.
