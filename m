Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTDVUqG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTDVUqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:46:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16519 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263852AbTDVUpW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:45:22 -0400
Date: Tue, 22 Apr 2003 17:00:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dave Mehler <dmehler26@woh.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 kernel hangs system
In-Reply-To: <000501c3090c$71683c60$0200a8c0@satellite>
Message-ID: <Pine.LNX.4.53.0304221649050.17809@chaos>
References: <000501c3090c$71683c60$0200a8c0@satellite>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, Dave Mehler wrote:

> Hello,
>     Ok, i've got a 2.5.68 kernel compilation that when i try to boot it it
> hangs the system. It gives me hex codes after it loads the kernel or if i
> have it load an initrd, it loads that then gives hex codes and stops.
>     I've got output from lspci -v and my config file at the following url:
> www.davemehler.net
>     Suggestions are desperately needed.
> If there's missing information that i should post please let me know and i
> will post it.
> Thanks.
> Dave.
>


First, I don't understand how as you say, "suggestions are
desperately needed" on a developmental kernel. These things are
not known to work on all configurations and some information like
"It gives me hex codes..." is worthless. Please write down
these "hex-codes" and, after booting a version the works, run them
through ksymoops. If you don't know what that is:


The latest version can be found in
ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops together
with patches to other utilities in order to give more accurate Oops
debugging.

FYI, after you run the text through ksymoops, you may find that it
occurs in a module that you really don't need to load at boot time.
Just remove that from initrd and try again.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

