Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUBADTj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 22:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUBADTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 22:19:39 -0500
Received: from ibague.terra.com.br ([200.154.55.225]:39384 "EHLO
	ibague.terra.com.br") by vger.kernel.org with ESMTP id S265193AbUBADTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 22:19:37 -0500
Subject: Re: no console with current (bk) kernel
From: Rafael Pereira <flip-flop@pop.com.br>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3fzdvy0te.fsf@lugabout.jhcloos.org>
References: <m3fzdvy0te.fsf@lugabout.jhcloos.org>
Content-Type: text/plain
Message-Id: <1075605603.4647.11.camel@fliflop.mosfet.bit>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 01 Feb 2004 01:20:03 -0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-01 at 00:45, James H. Cloos Jr. wrote:
> >From my .config:
> 
> # CONFIG_FB is not set
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VGA_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> 
> and yet the boot fails with a complaint that it cannot open a
> console, followed by a reboot.  (Too fast to copy anything down.)
> 
> Box is p3 notebook, gcc is 3.3.2 (gentoo -r5).
> 
> What am I missing?
> 
> -JimC


Did you enabled the:
CONFIG_FRAMEBUFFER_CONSOLE=y ???

try to enable it.

Rafael.


