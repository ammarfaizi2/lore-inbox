Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUEHN3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUEHN3V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 09:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUEHN3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 09:29:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8839 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263980AbUEHN3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 09:29:17 -0400
Date: Sat, 8 May 2004 09:31:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pascal Schmidt <der.eremit@email.de>
cc: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: Strange Linux behaviour!?
In-Reply-To: <E1BMBGn-0000Gj-8k@localhost>
Message-ID: <Pine.LNX.4.53.0405080928220.23992@chaos>
References: <1T8Ks-7ED-15@gated-at.bofh.it> <1T93S-7SM-11@gated-at.bofh.it>
 <1T9dz-80x-17@gated-at.bofh.it> <1ThkH-63V-1@gated-at.bofh.it>
 <E1BMBGn-0000Gj-8k@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004, Pascal Schmidt wrote:

> On Fri, 07 May 2004 19:30:08 +0200, you wrote in linux.kernel:
>
> > What happens when Linux runs out of inodes?  Why would it?  Doesn't it
> > create more?
>
> For many filesystems, the number of inodes *on* *disk* is set at
> mkfs time.
>
> --
> Ciao,
> Pascal
> -

You are being suckered in. "Out of inodes", roughly translated,
means "disk or disk partition is full". You can use `df -k` to
see.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


