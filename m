Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbRFSUXy>; Tue, 19 Jun 2001 16:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbRFSUXo>; Tue, 19 Jun 2001 16:23:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16914 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264766AbRFSUXb>; Tue, 19 Jun 2001 16:23:31 -0400
Subject: Re: Linux 2.4.5-ac16  (linux_booted_ok: only on Intel implemented)
To: martin.frey@compaq.com
Date: Tue, 19 Jun 2001 21:22:47 +0100 (BST)
Cc: laughing@shared-source.org ('Alan Cox'), linux-kernel@vger.kernel.org
In-Reply-To: <014801c0f8fa$a98ebbb0$0100007f@SCHLEPPDOWN> from "Martin Frey" at Jun 19, 2001 04:01:42 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CS1P-0006cz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> linux_booted_ok(), called from init/main.c is not implemented on
> other architectures than Intel.

Yeah. I just need to drop null functions in. Im still not sure if that should
in fact be invoked from user space - say on hitting run level 3
