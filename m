Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277380AbRKDBx3>; Sat, 3 Nov 2001 20:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277382AbRKDBxT>; Sat, 3 Nov 2001 20:53:19 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:28166 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277380AbRKDBxH>;
	Sat, 3 Nov 2001 20:53:07 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Achtzehn <linux-kernel@achtzehn.2y.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13: unresolved symbols with modules_install 
In-Reply-To: Your message of "Sat, 03 Nov 2001 15:48:18 BST."
             <01110315481802.06645@paris> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Nov 2001 12:52:55 +1100
Message-ID: <11324.1004838775@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2001 15:48:18 +0100, 
Andreas Achtzehn <linux-kernel@achtzehn.2y.net> wrote:
>/lib/modules/2.4.13/kernel/drivers/net/wan/comx.o
>depmod:         proc_get_inode

The comx.c code is wrong, it is still using an old interface.  This
problem has existed for months, nobody wants to fix it.  Turn off
CONFIG_COMX.

