Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264751AbUEOWHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264751AbUEOWHx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 18:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264752AbUEOWHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 18:07:53 -0400
Received: from lucidpixels.com ([66.45.37.187]:60827 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S264751AbUEOWHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 18:07:52 -0400
Date: Sat, 15 May 2004 18:07:50 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.5 emu10k1 module FAILS, built-in OK.
In-Reply-To: <Pine.LNX.4.58.0405151530590.16044@p500>
Message-ID: <Pine.LNX.4.58.0405151807300.16044@p500>
References: <Pine.LNX.4.58.0405151530590.16044@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me remind all; this is with _SMP_ kernel only, with a regular kernel
it makes the module and loads it fine.

Anyone aware of this problem?

On Sat, 15 May 2004, Justin Piszcz wrote:

> Script started on Sat May 15 14:47:08 2004
> # modprobe emu10k1
> FATAL: Error inserting emu10k1
> (/lib/modules/2.6.5/kernel/sound/oss/emu10k1/emu10k1.ko): Unknown symbol
> in module, or unknown parameter (see dmesg)
> root@war:~# dmesg | tail -n 1
>  emu10k1: Unknown symbol strcpy
>
>
