Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966723AbWKTWBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966723AbWKTWBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966748AbWKTWBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:01:08 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:32236 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S966723AbWKTWBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:01:07 -0500
Date: Mon, 20 Nov 2006 22:57:07 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: jes@trained-monkey.org, Adrian Bunk <bunk@stusta.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: xconfig segfault
In-Reply-To: <20061120102438.94ff4b0a.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0611202254200.6242@scrub.home>
References: <20061119161231.e509e5bf.randy.dunlap@oracle.com>
 <20061120004147.GC31879@stusta.de> <4560FB07.2040102@oracle.com>
 <20061120102438.94ff4b0a.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Nov 2006, Randy Dunlap wrote:

> I found the problem patch, but not the root cause.
> 
> The xconfig segfault begins in 2.6.19-rc5-git3 (-git2 is OK).
> A relatively simple Kconfig change causes it (but why?).
> 
> (Note:  The running kernel doesn't matter, just which kernel tree
> is being viewed/config-ed.)
> 
> If I back out the patches below, -git3 (xconfig ^F find/search)
> works for me.

I cannot reproduce this. Could you try to run qconf within gdb for a 
backtrace (adding -g to HOST_EXTRACFLAGS might get more useful output).

bye, Roman
