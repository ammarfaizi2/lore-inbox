Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276318AbRJUP6k>; Sun, 21 Oct 2001 11:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276329AbRJUP6b>; Sun, 21 Oct 2001 11:58:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8977 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276318AbRJUP6T>; Sun, 21 Oct 2001 11:58:19 -0400
Subject: Re: GPLONLY kernel symbols???
To: pierre@lineo.com
Date: Sun, 21 Oct 2001 17:05:03 +0100 (BST)
Cc: arjanv@redhat.com,
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3BCDFFE8.3DDB2591@lineo.com> from "pierre@lineo.com" at Oct 17, 2001 03:02:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vL5z-0006xC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes it is : what about the code that allows me
> to cat /proc/sys/kernel/tainted and echo an integer
> into it ? and the code that's not loaded into kernel
> memory sure takes storage space, even if it's not
> much.

That code is generic code already in the kernel for every other /proc
file. The total impact in bytes is shorter than the email. 

If you want to save space fix the page table mess and we can shave off
something like 8-16 bytes per page - Ie megabytes.

