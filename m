Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbRFUL46>; Thu, 21 Jun 2001 07:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbRFUL4j>; Thu, 21 Jun 2001 07:56:39 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:10697 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S264934AbRFUL4g>; Thu, 21 Jun 2001 07:56:36 -0400
Date: Thu, 21 Jun 2001 18:38:09 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Balbir Singh <balbir_soni@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <20010621104132.91801.qmail@web13609.mail.yahoo.com>
Message-ID: <Pine.SGI.4.10.10106211833390.3193032-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Balbir Singh wrote:

> I realize that the Linux kernel supports user
> level drivers (via ioperm, etc). However interrupts
> at user level are not supported, does anyone think
> it would be a good idea to add user level interrupt
> support ? I have a framework for it, but it still
> needs
> a lot of work.

http://www.ibiblio.org/pub/Linux/kernel/irq-1.68.2.tar.gz
 ftp://ftp.inp.nsk.su/export/fedorov/soft/irq-1.68.2.tar.gz

(2.0.x - 2.2.x kernels)

kernel module to delivery hardware interrupts to user space
programs. Hardware interrupts (IRQ) are accessible by
character devices /dev/irq[0-15]. Interrupts delivered by
signals and select(2)/poll(2)

