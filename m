Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVJMUSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVJMUSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVJMUSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:18:14 -0400
Received: from seqima.han-solo.net ([83.138.65.243]:56292 "EHLO
	seqima.han-solo.net") by vger.kernel.org with ESMTP id S932494AbVJMUSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:18:13 -0400
Message-ID: <434EC0FD.6000706@gmx.de>
Date: Thu, 13 Oct 2005 22:18:05 +0200
From: Georg Lippold <georg.lippold@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
References: <431628D5.1040709@zytor.com> <p73br1vsvup.fsf@verdi.suse.de> <434C1189.4090207@gmail.com> <200510112221.05789.ak@suse.de> <434C1AB6.5000104@gmail.com>
In-Reply-To: <434C1AB6.5000104@gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> OK... So I think 1024 bytes should be used... Does it sound OK?

So, it boils down to using my previously posted patch?

> But I still think that the documentation should not specify a fixed
> size, so that boot loaders will pass the full command line to the kernel.

In my patch, it states:

"a boot loader may allow
 a longer command line to be passed to permit future kernels to extend
 this limit."

(as always in Documentation/i386/boot.txt)

Greetings,

Georg
