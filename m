Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSLXSzy>; Tue, 24 Dec 2002 13:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbSLXSzy>; Tue, 24 Dec 2002 13:55:54 -0500
Received: from franka.aracnet.com ([216.99.193.44]:18888 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265736AbSLXSzx>; Tue, 24 Dec 2002 13:55:53 -0500
Date: Tue, 24 Dec 2002 11:04:02 -0800
From: "Martin J. Bligh" <fletch@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@zip.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix 4 compile time warnings in 2.5.53
Message-ID: <64430000.1040756642@titus>
In-Reply-To: <20021224182458.GL9704@holomorphy.com>
References: <48180000.1040751403@titus>
 <20021224182458.GL9704@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> drivers/serial/core.c: In function `uart_get_divisor':
>> drivers/serial/core.c:390: warning: `quot' might be used uninitialized
>> in  this function
>
> This is a (harmless) toolchain problem. Upgrading compilers (or patching
> your current compiler) fixes it. I've posted a "fix" for this before.

I refuse to upgrade the compiler on every machine in the lab from
standard Debian woody to fix one stupid compiler error. This is a
completely harmless substitution that makes the error go away. We
don't live in a theoretical utopia.

M.

