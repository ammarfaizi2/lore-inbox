Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262926AbSJGIoo>; Mon, 7 Oct 2002 04:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262929AbSJGIon>; Mon, 7 Oct 2002 04:44:43 -0400
Received: from 62-241-190-23.dsl.pipex.com ([62.241.190.23]:42758 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262926AbSJGIon>; Mon, 7 Oct 2002 04:44:43 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210070858.g978wioZ001386@darkstar.example.net>
Subject: Re: [BUG] - 2.5.40 xconfig and CONFIG_PARPORT_PC_PCMCIA
To: swdlinunx@earthlink.net (Steven W. Dover)
Date: Mon, 7 Oct 2002 09:58:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, bunk@fs.tum.de
In-Reply-To: <3DA0C155.2070503@earthlink.net> from "Steven W. Dover" at Oct 06, 2002 06:03:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Via make xconfig, two entries show up even though
> there is only one in the .config file, and you cannot
> set the entry with xconfig even when CONFIG_PARPORT=y
> and CONFIG_PARPORT_PC=y.  It is plain messed up.
> make menuconfig does not have this problem.

This is a known issue, (at least, I noticed it with 2.4.19).  Try this patch:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.0/0996.html

Adrian - could you send the patch to Linus, please, as it hasn't gone in to 2.5.x yet - we'll need it fixed for 2.6.x

John.
