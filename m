Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUC2P54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUC2P5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:57:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60035 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262974AbUC2P5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:57:54 -0500
Date: Mon, 29 Mar 2004 10:59:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Siseci <siseci@postmark.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x mount /dev/ram0 problem. 
In-Reply-To: <BMEEKPMJDEAFABBKPBBNMELBCBAA.siseci@postmark.net>
Message-ID: <Pine.LNX.4.53.0403291055450.16539@chaos>
References: <BMEEKPMJDEAFABBKPBBNMELBCBAA.siseci@postmark.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, Siseci wrote:

>
> Hi.
> I have a problem about ramdisk.
> Kernel version: 2.6.3 and 2.6.4
>
[SNIPPED...]

Verify that /dev/ram0 is not still mounted on /initrd.
I noticed that the stuff that uses initrd and pivot-root
for booting, works 'strangely' compared to the past. You
may find that /initrd remained mounted when you initialized
its virtual device, confusing the issue.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


