Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbTAJVyA>; Fri, 10 Jan 2003 16:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbTAJVyA>; Fri, 10 Jan 2003 16:54:00 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:19686 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266323AbTAJVx7>; Fri, 10 Jan 2003 16:53:59 -0500
Date: Fri, 10 Jan 2003 23:04:02 +0100
From: Dominik Brodowski <linux@brodo.de>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: menucofig[2.5.56] bug: help texts in "choice"
Message-ID: <20030110220402.GA1909@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.5.56 I'm seeing a bug in "make menuconfig" on x86: selecting "processor
type and features", then "processor family", and then "help" for any entry,
I always get "There is no help available for this kernel option." even
though there are extensive help texts in arch/i386/Kconfig.

BTW, just noticed that same is true for:
x86 - processor type and features - subarch
x86 - processor type and features - highmem
x86 - Bus options - PCI access mode 
...

maybe a bug for the "choice" entry?

	Dominik
