Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUALWqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUALWqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:46:08 -0500
Received: from [217.73.129.129] ([217.73.129.129]:37260 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263310AbUALWp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:45:58 -0500
Date: Tue, 13 Jan 2004 00:45:34 +0200
Message-Id: <200401122245.i0CMjYbn015552@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: loopback over reiserfs broken in 2.6.1-mm1
To: luto@myrealbox.com, linux-kernel@vger.kernel.org
References: <4002F317.2070102@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Andy Lutomirski <luto@myrealbox.com> wrote:

AL> on 2.6.1-mm1, where /var is reiserfs:
AL> [root@luto var]# dd if=/dev/zero of=foo count=1024
AL> 1024+0 records in
AL> 1024+0 records out
AL> [root@luto var]# losetup /dev/loop0 foo
AL> ioctl: LOOP_SET_FD: Invalid argument

Hm. Works with 2.6.1 for me.
Does it work with 2.6.1 for you as well?

Bye,
    Oleg
