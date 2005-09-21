Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVIUMAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVIUMAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 08:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVIUMAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 08:00:23 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:33130 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750836AbVIUMAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 08:00:23 -0400
Date: Wed, 21 Sep 2005 20:55:50 +0900 (JST)
Message-Id: <20050921.205550.927509530.hyoshiok@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: hyoshiok@miraclelinux.com
Subject: Linux Kernel Dump Summit 2005
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To whom may concern

We had a Linux Kernel Dump Summit 2005.

The participants are

Dump tools Session
diskdump -- Fujitsu
mkdump   -- NTT Data Intellilink
LTD      -- Hitachi
kdump    -- Turbolinux
Summary  -- Miracle Linux

Dump Analysis tools Session
Alicia/crash -- Uniadex

Other participants are
VA Linux/NEC/NSSOL/IPA/OSDL/Toshiba

Some discussion topics are (but not limited to)

- What kind of information do we need?
    trace information
    all of registers
    the last log of panic, oops
    LTD (Linux Tough Dump) has some nice features

- We need a partial dump
- We have to minimize the down time

- We have to dump all memory
    how can we distinguish from the kernel and user if
    kernel data is corrupted

- How we are not able to dump data
    device
    power management
    we need a generic mechanism to reset a device

- Hang
    NMI watch dog
    mount

- It is very difficult to debug a memory corrupt bug
- hardware error

- Where will we go to?
   IHV and Linux Kernel community collaboration are needed

Dump Analysis tools are very important

- There is a concern that the development process of 'crash'
is not open.
- Do we have to extend gdb?
- We'd like to collaborate 'crash'

- kexec/kdump, mkdump, LTD, all of them use the second kernel
to dump it.

- We have to share the test data, check list, test tools of
dump tool developments.

We agree to have the Linux Kernel Dump Summit.

Regards,
  Hiro
