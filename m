Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbRLZJAe>; Wed, 26 Dec 2001 04:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286189AbRLZJAY>; Wed, 26 Dec 2001 04:00:24 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:14090 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286188AbRLZJAT>;
	Wed, 26 Dec 2001 04:00:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Luca Amigoni <al.net@libero.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Davicom DM910x (dfme) doesn't link 
In-Reply-To: Your message of "Wed, 26 Dec 2001 09:26:33 BST."
             <20011226092633.A9287@mater.home> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Dec 2001 20:00:05 +1100
Message-ID: <6384.1009357205@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2001 09:26:33 +0100, 
Luca Amigoni <al.net@libero.it> wrote:
>I've tried to compile kernel version 2.4.17 with static dfme support,
>but ld fails to link. Here is the error I get:
>
>drivers/net/net.o(.data+0x434): undefined reference to `local symbols \
>      in discarded section .text.exit'

Known problem, the fix will be in 2.4.18-pre<something>.  Use the
previous version of binutils until the kernel is fixed.

