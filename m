Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWETNot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWETNot (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 09:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWETNos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 09:44:48 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:45770 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S964849AbWETNos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 09:44:48 -0400
Subject: Re: Oops in kthread
From: Arjan van de Ven <arjan@infradead.org>
To: Liu haixiang <liu.haixiang@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bf3792800605200537o2c9c8c47t9310321ae9205296@mail.gmail.com>
References: <bf3792800605200537o2c9c8c47t9310321ae9205296@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 20 May 2006 15:44:45 +0200
Message-Id: <1148132686.3041.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-20 at 20:37 +0800, Liu haixiang wrote:
> Hi All,
> 
> Today I debug one kernel thread created by kthread_run. And after
> several hours run, there is one Oops coming from kthread. Please see
> below mesage:
> ====================
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pc = 00000000
> *pde = 00000000
> Oops: 0000 [#1]
> 
> Pid : 261, Comm:      CallbackManager
> PC is at 0x0
> PC  : 00000000 SP  : 869bbf8c SR  : 40008100 TEA : c016db88    Tainted: P
> R0  : 00000000 R1  : 00000000 R2  : 005770c5 R3  : 40008101
> R4  : 8b000006 R5  : 00000003 R6  : 07b1ce60 R7  : 00000079
> R8  : c01c0800 R9  : 07b1ce60 R10 : 00000003 R11 : 00000000
> R12 : 0000004c R13 : 00000000 R14 : 00000079
> MACH: 0000025c MACL: 000001c8 GBR : 00000000 PR  : c01b514a
> 
> Call trace:
> [<8442d184>] kthread+0xe4/0x140
> [<c01b4f80>] CallbackManager+0x0/0x2c0 [fdma]

you forgot to attach the source code for "fdma"... so how can we help
you?

