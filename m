Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTJPUNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 16:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTJPUNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 16:13:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18048 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263106AbTJPUNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 16:13:39 -0400
Date: Thu, 16 Oct 2003 16:13:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: sting sting <zstingx@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: short explanation -jiffies (newbie)
In-Reply-To: <Sea2-F17IdRclmEBOum000104f7@hotmail.com>
Message-ID: <Pine.LNX.4.53.0310161610550.1209@chaos>
References: <Sea2-F17IdRclmEBOum000104f7@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, sting sting wrote:

> Hello,
> can someone give a short explanation what jiffies are?
> regards
> sting

It is a variable that keeps increasing forever until
it wraps back to zero at which time it still keeps
increasing. It gets increased at the HZ (a defined constant)
rate as a result of a hardware interrupt.

It is used for various timing functions within the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


