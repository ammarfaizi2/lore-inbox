Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSIHWbG>; Sun, 8 Sep 2002 18:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSIHWbG>; Sun, 8 Sep 2002 18:31:06 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:53689 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S315440AbSIHWbC>; Sun, 8 Sep 2002 18:31:02 -0400
Date: Sun, 8 Sep 2002 15:35:39 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Odd problem with ACPI and i386 kernel
Message-ID: <20020908153539.A21352@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a very strange problem with ACPI and i386 kernel. I built an
i386 kernel with ACPI for RedHat installation since my new P4 machines
needs ACPI to get IRQ. It works fine on my ASUS P4B533-E MB with Intel
845E chipset. However, on my Sony VAIO GRX560 which is a P4 1.6GHz
with Intel 845 chipset, the machine will reboot as soon as the kernel
starts to run. I tracked it down to CONFIG_X86_INVLPG. If I enable
it, kernel will be fine. Has anyone else seen this?


H.J.
