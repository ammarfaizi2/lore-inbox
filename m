Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUJRL2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUJRL2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 07:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUJRL2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 07:28:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266169AbUJRL2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 07:28:04 -0400
Date: Mon, 18 Oct 2004 07:27:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: 7eggert@nurfuerspam.de
cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <E1CJCic-0001uC-00@be1.7eggert.dyndns.org>
Message-ID: <Pine.LNX.4.61.0410180724110.18025@chaos.analogic.com>
References: <fa.ghoqtmo.8nqeb0@ifi.uio.no> <fa.jtpibm5.1l4ki17@ifi.uio.no>
 <E1CJCic-0001uC-00@be1.7eggert.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004, Bodo Eggert wrote:

> Richard B. Johnson wrote:
>
>> One can make a 'certified' kernel with 'certified' modules
>> for some hush-hush project. Adding this kind of junk isn't
>> how it's done. You just take your favorite kernel with the
>> modules you require, you verify that it meets your security
>> requirements, then you CRC the kernel and its modules. You
>> keep the CRCs somewhere safe, available from a read-only
>> source like a CD/ROM or a network file-server. You automatically
>> check these CRCs occasionally using a read-only program on
>> read-only source like the network or a CD/ROM. If the checks
>> fail, you call the "super" and shut down the system.
>
> If a malicious module loads, you lose instantly. You cannot relaibly check
> module integrity on this system anymore. E.g. the malicious module might
> patch the module checker to check a signed module instead of the malicious
> one. Or the Exploit saves the old module, puts in the patched one, loads it
> and puts the old one back in place.
>

What malicious module?  They have all been certified. That ARE NO
OTHER modules. If you don't do it this way, i.e., if you allow
anybody to load a module, then you have no security, regardless of
what's in the module, the loader, or the kernel. Any crap inside
either of these is crap. Then can all be modified to do anything
so gigibytes of "protective" software is absouye bullshit, and
a lot of memory wasted.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

