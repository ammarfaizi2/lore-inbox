Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSGGCmj>; Sat, 6 Jul 2002 22:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSGGCmi>; Sat, 6 Jul 2002 22:42:38 -0400
Received: from adsl-65-69-128-164.dsl.rcsntx.swbell.net ([65.69.128.164]:45308
	"EHLO keyser.soze.net") by vger.kernel.org with ESMTP
	id <S314395AbSGGCmi>; Sat, 6 Jul 2002 22:42:38 -0400
Date: Sun, 7 Jul 2002 02:45:16 +0000
From: Justin Guyett <justin@soze.net>
To: linux-kernel@vger.kernel.org
Subject: Re: dead processes in 2.4.7-10smp and 2.4.19-rc1 (percraid problem?)
Message-ID: <20020707024516.GD14028@dreams.soze.net>
References: <20020706200214.GB12813@dreams.soze.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020706200214.GB12813@dreams.soze.net>
X-PGP-Fingerprint: 9AE2 9FC3 D98B 9AE2 EE83  15CC 9C7D 1925 4568 5243
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jul  6 14:38:55 broken kernel: chmod         T F7547500  5772   179 1   185     210   138 (NOTLB)
> Jul  6 14:38:55 broken kernel: Call Trace: [do_signal+166/688] [dev_ifsioc+31/1104] [sock_ioctl+63/128] [sys_ioctl+193/527] [signal_return+20/24]
> Jul  6 14:38:55 broken kernel: chmod         Z F75475A0  5840   185 179                     (L-TLB)
> Jul  6 14:38:55 broken kernel: Call Trace: [do_exit+711/768] [sig_exit+195/208] [dequeue_signal+100/208] [do_signal+450/688] [sock_write+174/208]
> Jul  6 14:38:55 broken kernel:    [sys_write+265/352] [signal_return+20/24]

No need for anyone to chase this down; it was indeed Remote Shell
Trojan b.

justin

